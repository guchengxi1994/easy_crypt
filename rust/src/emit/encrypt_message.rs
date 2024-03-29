use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct EncryptMessage {
    pub file_path: String,
    pub total_size: u64,
    pub encrypt_size: u64,
    pub unique_id: Option<i64>,
    #[serde(rename = "type")]
    pub _type: i8,
}

impl EncryptMessage {
    pub fn default() -> Self {
        Self {
            file_path: "".to_owned(),
            total_size: 0,
            encrypt_size: 0,
            unique_id: None,
            _type: crate::constants::TYPE_ENCRYPT,
        }
    }

    pub fn is_done(&self) -> bool {
        self.encrypt_size == self.total_size && self.total_size > 0
    }
}

impl Emitter for EncryptMessage {}
