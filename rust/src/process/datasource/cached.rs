use std::time::UNIX_EPOCH;

use aes_gcm_siv::{aead::Aead, Aes256GcmSiv, KeyInit, Nonce};
use opendal::raw::oio::ReadExt;

use crate::{
    api::crypt::random_key,
    constants::{CUSTOM_HEADER, SIXTEEN_MB},
    emit::{emitter::Emitter, two_datasource_transfer_message::TwoDatasourceTransferMessage},
};

use super::{base_trait::ClientTrait, local::LocalStorage, s3::S3Client};

pub struct TwoDatasources {
    pub left: Option<Box<dyn ClientTrait + Send + Sync>>,
    pub right: Option<Box<dyn ClientTrait + Send + Sync>>,
}

impl TwoDatasources {
    pub fn default() -> Self {
        TwoDatasources {
            left: None,
            right: None,
        }
    }
    pub fn set_left(&mut self, left: Box<dyn ClientTrait + Send + Sync>) {
        self.left = Some(left);
    }

    pub fn set_right(&mut self, right: Box<dyn ClientTrait + Send + Sync>) {
        self.right = Some(right);
    }

    pub async fn transfer_from_left_to_right(
        &self,
        p: String,
        save_path: String,
        auto_encrypt: bool,
    ) -> anyhow::Result<()> {
        if let Some(_left) = &self.left {
            if let Some(_right) = &self.right {
                Self::transfer(&_left, &_right, p, save_path, auto_encrypt).await?;
            } else {
                anyhow::bail!("right datasource error")
            }
        } else {
            anyhow::bail!("left datasource error")
        }

        anyhow::Ok(())
    }

    async fn transfer(
        left: &Box<dyn ClientTrait + Send + Sync>,
        right: &Box<dyn ClientTrait + Send + Sync>,
        p: String,
        save_path: String,
        /* not work right now*/ auto_encrypt: bool,
    ) -> anyhow::Result<()> {
        let mut message = TwoDatasourceTransferMessage::default()?;
        message.file_path = p.clone();
        message.save_path = save_path.clone();
        message.auto_encrypt = auto_encrypt;
        let key = random_key();

        if auto_encrypt {
            message.key = Some(key.clone());
        }

        let left_down: &dyn ClientTrait;
        if let Some(_left) = left.as_any().downcast_ref::<S3Client>() {
            left_down = _left;
        } else {
            left_down = left.as_any().downcast_ref::<LocalStorage>().unwrap();
        }
        message.from = left_down.get_name();

        let right_down: &dyn ClientTrait;
        if let Some(_right) = right.as_any().downcast_ref::<S3Client>() {
            right_down = _right;
        } else {
            right_down = right.as_any().downcast_ref::<LocalStorage>().unwrap();
        }
        message.to = right_down.get_name();

        let mut reader = left_down.get_op().reader(&p).await?;
        let mut writer = right_down.get_op().writer(&save_path).await?;

        println!("from  {:?}  to  {:?}", p, save_path);

        let mut buffer = vec![0; SIXTEEN_MB.try_into().unwrap()]; // 16MB
        let mut transfered = 0;

        if !auto_encrypt {
            loop {
                let count = reader.read(&mut buffer).await?;
                if count == 0 {
                    break;
                }
                writer.write(buffer[..count].to_vec()).await?;
                transfered += count;

                let duration = std::time::SystemTime::now()
                    .duration_since(UNIX_EPOCH)
                    .unwrap()
                    .as_secs()
                    - message.start_time;

                if duration > 0 {
                    let speed = (transfered as f64) / (duration as f64);
                    message.set_speed(speed);
                }
                message.send_message();
            }
        } else {
            println!("[rust] auto encrypt");
            let cipher = Aes256GcmSiv::new(key.clone().as_bytes().into());
            let nonce = Nonce::from_slice(b"_EasyCrypt__"); // 96-bits; unique per message
                                                            // writer.write(CUSTOM_HEADER.as_bytes()).await?;
            let mut index = 0;
            loop {
                let count = reader.read(&mut buffer).await?;
                if count == 0 {
                    break;
                }
                let ciphertext = cipher.encrypt(nonce, &buffer[..count]);

                if let Ok(text) = ciphertext {
                    if index == 0 {
                        let mut v = CUSTOM_HEADER.as_bytes().to_vec();
                        v.extend(text);
                        writer.write(v).await?;
                    } else {
                        writer.write(text).await?;
                    }

                    transfered += count;
                    let duration = std::time::SystemTime::now()
                        .duration_since(UNIX_EPOCH)
                        .unwrap()
                        .as_secs()
                        - message.start_time;

                    if duration > 0 {
                        let speed = (transfered as f64) / (duration as f64);
                        message.set_speed(speed);
                    }
                } else {
                    println!("[rust] enctypt error");
                    anyhow::bail!("encrypt err")
                }

                message.send_message();
            }
        }

        writer.close().await?;
        message.msg = Some("done".to_owned());
        message.send_message();

        println!("transfered  {:?}", transfered);

        anyhow::Ok(())
    }
}

#[deprecated(note = "use `TwoDatasources` instead, that's simpler")]
pub struct CacheDatasources {
    pub datasources: Vec<Box<dyn ClientTrait + Send + Sync>>,
}

impl CacheDatasources {
    pub fn default() -> Self {
        CacheDatasources {
            datasources: Vec::new(),
        }
    }

    pub async fn transfer_from_left_to_right(
        &self,
        left_index: usize,
        right_index: usize,
        p: String,
        save_path: String,
        auto_encrypt: bool,
    ) -> anyhow::Result<()> {
        let left = self.datasources.get(left_index);
        let right = self.datasources.get(right_index);
        match (left, right) {
            (None, None) => anyhow::bail!("datasource error"),
            (None, Some(_)) => anyhow::bail!("datasource error"),
            (Some(_), None) => anyhow::bail!("datasource error"),
            (Some(_left), Some(_right)) => {
                Self::transfer(_left, _right, p, save_path, auto_encrypt).await?;
            }
        }

        anyhow::Ok(())
    }

    async fn transfer(
        left: &Box<dyn ClientTrait + Send + Sync>,
        right: &Box<dyn ClientTrait + Send + Sync>,
        p: String,
        save_path: String,
        /* not work right now*/ auto_encrypt: bool,
    ) -> anyhow::Result<()> {
        let left_down: &dyn ClientTrait;
        if let Some(_left) = left.as_any().downcast_ref::<S3Client>() {
            left_down = _left;
        } else {
            left_down = left.as_any().downcast_ref::<LocalStorage>().unwrap();
        }

        let right_down: &dyn ClientTrait;
        if let Some(_right) = right.as_any().downcast_ref::<S3Client>() {
            right_down = _right;
        } else {
            right_down = right.as_any().downcast_ref::<LocalStorage>().unwrap();
        }

        let mut reader = left_down.get_op().reader(&p).await?;
        let mut writer = right_down.get_op().writer(&save_path).await?;

        let mut buffer = vec![0; SIXTEEN_MB.try_into().unwrap()]; // 16MB
        let mut transfered = 0;

        loop {
            let count = reader.read(&mut buffer).await?;
            if count == 0 {
                break;
            }
            writer.write(buffer[..count].to_vec()).await?;
            transfered += count;
        }

        anyhow::Ok(())
    }
}
