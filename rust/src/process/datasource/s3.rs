use std::{
    fs::{self, File},
    io::Write,
    time::{SystemTime, UNIX_EPOCH},
};

use async_trait::async_trait;
use opendal::raw::oio::ReadExt;

use crate::{constants::SIXTEEN_MB, emit::emitter::Emitter};

use super::{
    base_trait::{ClientTrait, Transfer},
    Entry, EntryType, S3CLIENT,
};

pub struct S3Client {
    pub endpoint: String,
    pub bucketname: String,
    pub access_key: String,
    pub session_key: String,
    pub session_token: Option<String>,
    pub region: String,
    pub op: opendal::Operator,
}

impl ClientTrait for S3Client {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }

    fn get_op(&self) -> opendal::Operator {
        self.op.clone()
    }

    // async fn list_objects(&self, p: String) -> Vec<Entry> {
    //     self.list_objs(p).await
    // }
}

impl S3Client {
    pub fn from(
        endpoint: String,
        bucketname: String,
        access_key: String,
        session_key: String,
        session_token: Option<String>,
        region: String,
    ) -> Option<Self> {
        let mut builder = opendal::services::S3::default();
        builder.endpoint(&endpoint);
        builder.bucket(&bucketname);
        builder.access_key_id(&access_key);
        builder.secret_access_key(&session_key);
        if let Some(_s) = session_token.clone() {
            builder.security_token(&_s);
        }
        builder.region(&region);
        let op = opendal::Operator::new(builder);

        match op {
            Ok(_op) => {
                let _o = _op.layer(opendal::layers::LoggingLayer::default()).finish();
                let client = S3Client {
                    endpoint,
                    bucketname,
                    access_key,
                    session_key,
                    session_token,
                    region,
                    op: _o,
                };
                return Some(client);
            }
            Err(_) => None,
        }
    }

    pub async fn check_available(&self) -> bool {
        let r = self.op.list_with("/").await;
        return r.is_ok();
    }

    pub async fn list_objs(&self, path: String) -> Vec<Entry> {
        let r = self.op.list_with(&path).await;
        match r {
            Ok(_r) => {
                let mut v = Vec::new();

                for i in _r {
                    if i.metadata().is_dir() {
                        v.push(Entry {
                            _type: EntryType::Folder,
                            path: i.path().to_owned(),
                        });
                    } else {
                        v.push(Entry {
                            _type: EntryType::File,
                            path: i.path().to_owned(),
                        });
                    }
                }

                v
            }
            Err(_) => {
                vec![]
            }
        }
    }
}

impl S3Client {
    // unused , remove later
    pub fn init(
        endpoint: String,
        bucketname: String,
        access_key: String,
        session_key: String,
        session_token: Option<String>,
        region: String,
    ) {
        let mut builder = opendal::services::S3::default();
        builder.endpoint(&endpoint);
        builder.bucket(&bucketname);
        builder.access_key_id(&access_key);
        builder.secret_access_key(&session_key);
        if let Some(_s) = session_token.clone() {
            builder.security_token(&_s);
        }
        builder.region(&region);

        let op = opendal::Operator::new(builder);
        match op {
            Ok(_op) => {
                let _o = _op.layer(opendal::layers::LoggingLayer::default()).finish();
                let client = S3Client {
                    endpoint,
                    bucketname,
                    access_key,
                    session_key,
                    session_token,
                    region,
                    op: _o,
                };

                let mut c = S3CLIENT.write().unwrap();
                *c = Some(client);
            }
            Err(_) => {}
        }
    }
}

#[async_trait]
impl Transfer for S3Client {
    async fn upload(
        &self,
        p: String,
        object_path: String,
        message: &mut crate::emit::file_transfer_message::FileTransferMessage,
    ) -> anyhow::Result<()> {
        // let mut message = crate::emit::file_transfer_message::FileTransferMessage::new(p.clone())?;

        let mut writer = self.op.writer(&object_path).await?;
        let mut file = File::open(p.clone())?;
        let meta = fs::metadata(p)?;
        let mut buffer = vec![0; SIXTEEN_MB.try_into().unwrap()]; // 16MB
        let mut transfered = 0;

        loop {
            let count = std::io::Read::read(&mut file, &mut buffer)?;
            if count == 0 {
                break;
            }

            writer.write(buffer[..count].to_vec()).await?;

            let duration = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs()
                - message.get_start_time();
            transfered += count;
            if duration > 0 {
                let speed = (transfered as f64) / (duration as f64);
                message.set_speed(speed);
            }
            message.progress = (transfered as f64) / (meta.len() as f64);
            message.send_message();
        }

        writer.close().await?;

        anyhow::Ok(())
    }

    async fn download(&self, p: String, object_path: String) -> anyhow::Result<()> {
        let mut message = crate::emit::file_transfer_message::FileTransferMessage::new(p.clone())?;
        let mut reader = self.op.reader(&object_path).await?;
        let mut file_save = std::fs::File::create(p)?;
        let mut buffer = vec![0; SIXTEEN_MB.try_into().unwrap()]; // 16MB
        let mut transfered = 0;
        let meta = self.op.stat(&object_path).await?;

        loop {
            let count = reader.read(&mut buffer).await?;
            if count == 0 {
                break;
            }

            file_save.write_all(&buffer[..count])?;

            let duration = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs()
                - message.get_start_time();
            transfered += count;
            if duration > 0 {
                let speed = (transfered as f64) / (duration as f64);
                message.set_speed(speed);
            }
            message.progress = (transfered as f64) / (meta.content_length() as f64);
            message.send_message();
        }

        anyhow::Ok(())
    }

    async fn share(&self, object_path: String) -> anyhow::Result<String> {
        if self.op.is_exist(&object_path).await? {
            let presign = self
                .op
                .presign_read(&object_path, std::time::Duration::from_secs(3600))
                .await?;
            return anyhow::Ok(presign.uri().to_string());
        }

        anyhow::Ok("".to_owned())
    }
}
