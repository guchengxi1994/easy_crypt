use crate::constants::ONE_MB;
use serde::{Deserialize, Serialize};
use std::time::{SystemTime, UNIX_EPOCH};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct FileTransferMessage {
    file_path: String,
    start_time: u64,
    transfer_speed: String,
    #[serde(rename = "type")]
    pub _type: i8,
    pub progress: f64,
}

impl FileTransferMessage {
    pub fn new(p: String) -> anyhow::Result<Self> {
        anyhow::Ok(FileTransferMessage {
            file_path: p,
            start_time: SystemTime::now().duration_since(UNIX_EPOCH)?.as_secs(),
            transfer_speed: "0.0 MB/s".to_owned(),
            _type: crate::constants::TYPE_TRANSFER,
            progress: 0.0,
        })
    }

    pub fn get_start_time(&self) -> u64 {
        self.start_time
    }

    pub fn set_speed(&mut self, f: f64) {
        self.transfer_speed = format!("{:.2} MB/s", f / (ONE_MB as f64))
    }
}

impl Emitter for FileTransferMessage {}
