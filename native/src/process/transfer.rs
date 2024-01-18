use std::{
    fs::File,
    io::Write,
    sync::RwLock,
    time::{SystemTime, UNIX_EPOCH},
};

use async_trait::async_trait;
use once_cell::sync::Lazy;
use opendal::raw::oio::ReadExt;

use crate::{constants::SIXTEEN_MB, emit::emitter::Emitter};

#[async_trait]
pub trait Transfer {
    async fn upload(&self, p: String, object_path: String) -> anyhow::Result<()>;

    async fn download(&self, p: String, object_path: String) -> anyhow::Result<()>;
}

pub static S3CLIENT: Lazy<RwLock<Option<S3Client>>> = Lazy::new(|| RwLock::new(None));

pub struct S3Client {
    pub endpoint: String,
    pub bucketname: String,
    pub access_key: String,
    pub session_key: String,
    pub session_token: Option<String>,
    pub region: String,
    op: opendal::Operator,
}

impl S3Client {
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
    async fn upload(&self, p: String, object_path: String) -> anyhow::Result<()> {
        let mut message = crate::emit::file_transfer_message::FileTransferMessage::new(p.clone())?;

        let mut writer = self.op.writer(&object_path).await?;
        let mut file = File::open(p)?;
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
            message.send_message();
        }

        anyhow::Ok(())
    }
}
