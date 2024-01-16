use aes_gcm_siv::{aead::Aead, Aes256GcmSiv, KeyInit, Nonce};

use super::Operate;

pub struct AesOperator {
    pub key: String,
    pub nonce: String,
}

impl AesOperator {
    pub fn default() -> AesOperator {
        AesOperator {
            key: crate::constants::DEFAULT_AES_KEY.to_owned(),
            nonce: "_EasyCrypt__".to_owned(),
        }
    }
}

impl Operate for AesOperator {
    fn operate(&self, d: &[u8]) -> Vec<u8> {
        let cipher = Aes256GcmSiv::new(self.key.as_bytes().into());
        let nonce = Nonce::from_slice(self.nonce.as_bytes()); // 96-bits; unique per message
        let ciphertext = cipher.encrypt(nonce, d);
        // return ciphertext;
        match ciphertext {
            Ok(_c) => _c,
            Err(e) => {
                println!("error {:?}", e);
                vec![]
            }
        }
    }

    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}

pub struct AesDecryptOperator {
    pub key: String,
    pub nonce: String,
}

impl Operate for AesDecryptOperator {
    fn operate(&self, d: &[u8]) -> Vec<u8> {
        let cipher = Aes256GcmSiv::new(self.key.as_bytes().into());
        let nonce = Nonce::from_slice(self.nonce.as_bytes()); // 96-bits; unique per message
        let ciphertext = cipher.decrypt(nonce, d);
        // return ciphertext;
        match ciphertext {
            Ok(_c) => _c,
            Err(e) => {
                println!("error {:?}", e);
                vec![]
            }
        }
    }

    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}
