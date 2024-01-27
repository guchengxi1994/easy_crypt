use opendal::raw::oio::ReadExt;

use crate::constants::SIXTEEN_MB;

use super::{base_trait::ClientTrait, local::LocalStorage, s3::S3Client};

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
