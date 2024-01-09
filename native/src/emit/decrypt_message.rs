use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct DecryptMessage {
    pub file_path: String,
    pub total_size: usize,
    pub encrypt_size: usize,
    pub uuid: Option<String>,
    #[serde(rename = "type")]
    pub _type: i8,
}

impl DecryptMessage {
    pub fn default() -> Self {
        Self {
            file_path: "".to_owned(),
            total_size: 0,
            encrypt_size: 0,
            uuid: Some("".to_owned()),
            _type: crate::constants::TYPE_DECRYPT,
        }
    }
}

impl Emitter for DecryptMessage {}
