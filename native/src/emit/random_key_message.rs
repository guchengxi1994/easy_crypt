use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use serde::{Deserialize, Serialize};

use super::emitter::Emitter;

#[derive(Serialize, Deserialize, Debug)]
pub struct RandomKeyMessage {
    pub key: String,
    #[serde(rename = "type")]
    pub _type: i8,
}

#[allow(dead_code)]
impl RandomKeyMessage {
    pub fn default() -> Self {
        Self {
            key: String::from(crate::constants::DEFAULT_AES_KEY),
            _type: crate::constants::TYPE_KEY,
        }
    }

    pub fn random() -> anyhow::Result<Self> {
        // let key = Aes256GcmSiv::generate_key(&mut OsRng);
        let rand_string: String = thread_rng()
            .sample_iter(&Alphanumeric)
            .take(32)
            .map(char::from)
            .collect();

        anyhow::Ok(Self {
            key: rand_string.to_lowercase(),
            _type: crate::constants::TYPE_KEY,
        })
    }

    pub fn get_key(&self) -> &[u8] {
        let v = self.key.as_bytes();
        v
    }
}

impl Emitter for RandomKeyMessage {}
