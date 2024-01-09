use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct ZipFileMessage {
    pub total: usize,
    pub current: usize,
    pub current_path: String,
    #[serde(rename = "type")]
    pub _type: i8,
}

impl ZipFileMessage {
    pub fn default() -> Self {
        Self {
            total: 0,
            current: 0,
            current_path: "".to_owned(),
            _type: crate::constants::TYPE_ZIP_FILE,
        }
    }
}

impl Emitter for ZipFileMessage {}
