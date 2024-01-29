use std::{
    fs::{self, File},
    io::{BufReader, Read},
};

use md5::compute as md5compute;

use crate::constants::SIXTEEN_MB;

#[allow(dead_code)]
pub struct S3Check {
    file_path: String,
    object_path: String,
    operator: opendal::Operator,
    file_meta: Option<fs::Metadata>,
    object_meta: Option<opendal::Metadata>,
}

impl S3Check {
    pub async fn new(file_path: String, object_path: String, operator: opendal::Operator) -> Self {
        let meta = operator.stat(&object_path).await;

        let local_meta = fs::metadata(file_path.clone());

        match (meta, local_meta) {
            (Ok(m1), Ok(m2)) => Self {
                file_path,
                object_path,
                operator,
                file_meta: Some(m2),
                object_meta: Some(m1),
            },
            (Ok(m1), Err(_)) => Self {
                file_path,
                object_path,
                operator,
                file_meta: None,
                object_meta: Some(m1),
            },
            (Err(_), Ok(m2)) => Self {
                file_path,
                object_path,
                operator,
                file_meta: Some(m2),
                object_meta: None,
            },
            (Err(_), Err(_)) => Self {
                file_path,
                object_path,
                operator,
                file_meta: None,
                object_meta: None,
            },
        }
    }

    pub async fn check_etag(&self) -> anyhow::Result<bool> {
        let r = self.get_file_etag()?;
        if let Some(meta) = &self.object_meta {
            if let Some(e) = meta.etag() {
                return anyhow::Ok(e == r);
            }
        }

        anyhow::Ok(false)
    }

    pub async fn check_size(&self) -> bool {
        if self.file_meta.is_none() || self.object_meta.is_none() {
            return false;
        }

        self.object_meta.clone().unwrap().content_length() == self.file_meta.clone().unwrap().len()
    }

    fn get_file_etag(&self) -> anyhow::Result<String> {
        if self.file_meta.is_none() {
            anyhow::bail!("file error")
        }

        let file = File::open(&self.file_path)?;
        let mut reader = BufReader::new(file);
        let mut buffer = vec![0; SIXTEEN_MB.try_into().unwrap()];

        if self.file_meta.clone().unwrap().len() <= SIXTEEN_MB {
            let count = reader.read(&mut buffer)?;
            let h = md5compute(&buffer[..count]);
            return anyhow::Ok(format!("{:x}", h));
        }

        let mut etags = Vec::new();
        let mut pcount = 0;

        loop {
            let count = reader.read(&mut buffer)?;
            if count == 0 {
                break;
            }
            let h = md5compute(&buffer[..count]);
            etags.append(&mut h.0.to_vec());
            pcount += 1;
        }
        let etag = md5compute(etags);
        let tag = hex::encode(&etag[..16]);

        println!("[rust] {:?}", tag);

        anyhow::Ok(format!("{}-{}", tag, pcount))
    }
}
