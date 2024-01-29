use std::time::{SystemTime, UNIX_EPOCH};

use serde::{Deserialize, Serialize};

use crate::constants::ONE_MB;

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct TwoDatasourceTransferMessage {
    pub from: String,
    pub to: String,
    pub file_path: String,
    pub save_path: String,
    pub start_time: u64,
    pub transfer_speed: String,
    #[serde(rename = "type")]
    pub _type: i8,
    pub msg: Option<String>,
    pub auto_encrypt: bool,
    pub key: Option<String>,
}

impl TwoDatasourceTransferMessage {
    pub fn default() -> anyhow::Result<Self> {
        anyhow::Ok(Self {
            from: "".to_owned(),
            to: "".to_owned(),
            file_path: "".to_owned(),
            save_path: "".to_owned(),
            start_time: SystemTime::now().duration_since(UNIX_EPOCH)?.as_secs(),
            transfer_speed: "0.0 MB/s".to_owned(),
            _type: crate::constants::TYPE_TWO_DATASOURCE_TRANSFER,
            msg: None,
            auto_encrypt: false,
            key: None,
        })
    }

    pub fn set_speed(&mut self, f: f64) {
        self.transfer_speed = format!("{:.2} MB/s", f / (ONE_MB as f64))
    }
}

impl Emitter for TwoDatasourceTransferMessage {}
