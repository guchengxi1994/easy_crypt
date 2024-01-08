use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct DecryptMessage {
    pub file_path: String,
    pub total_size: usize,
    pub encrypt_size: usize,
    pub uuid: Option<String>,
}

impl Emitter for DecryptMessage {}
