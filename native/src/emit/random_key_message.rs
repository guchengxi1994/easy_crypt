use aes_gcm_siv::{
    aead::{KeyInit, OsRng},
    Aes256GcmSiv,
};
use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct RandomKeyMessage {
    pub key: String,
}

#[allow(dead_code)]
impl RandomKeyMessage {
    pub fn default() -> Self {
        Self {
            key: String::from(crate::constants::DEFAULT_AES_KEY),
        }
    }

    pub fn random() -> anyhow::Result<Self> {
        let key = Aes256GcmSiv::generate_key(&mut OsRng);

        anyhow::Ok(Self {
            key: String::from_utf8(key.to_vec())?,
        })
    }

    pub fn get_key(&self) -> &[u8] {
        let v = self.key.as_bytes();
        v
    }
}

impl Emitter for RandomKeyMessage {}
