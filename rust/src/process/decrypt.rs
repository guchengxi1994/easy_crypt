use std::{
    io::{Read, Write},
    path::Path,
};

use aes_gcm_siv::{aead::Aead, Aes256GcmSiv, KeyInit, Nonce};

#[derive(Debug, Clone)]
pub struct Decrypt {
    pub path: String,
    pub key: String,
    pub save_dir: String,
    pub file_type: Option<String>,
}

impl Decrypt {
    pub fn decrypt_file(&self) -> anyhow::Result<String> {
        let path = Path::new(&self.path);
        let file_stem = path.file_stem().unwrap().to_str().unwrap();
        let file_save_path;

        match &self.file_type {
            Some(_t) => {
                file_save_path = format!("{}/{}.{}", self.save_dir, file_stem, _t);
            }
            None => {
                file_save_path = format!("{}/{}", self.save_dir, file_stem);
            }
        }
        let mut file = std::fs::File::open(self.path.clone())?;
        let mut custom_header_buffer = vec![0; crate::constants::CUSTOM_HEADER.len()];

        let _ = file.read(&mut custom_header_buffer)?;

        if String::from_utf8(custom_header_buffer)? != crate::constants::CUSTOM_HEADER {
            anyhow::bail!("this is not an EasyCrypt file")
        }

        let mut file_save = std::fs::File::create(file_save_path.clone())?;
        let mut buffer = vec![0; crate::constants::AES_ENCRYPT_ONE_MB.try_into().unwrap()];

        let cipher = Aes256GcmSiv::new(self.key.as_bytes().into());
        let nonce = Nonce::from_slice(b"_EasyCrypt__"); // 96-bits; unique per message

        while let Ok(n) = std::io::Read::read(&mut file, &mut buffer) {
            if n == 0 {
                break;
            }

            let ciphertext = cipher.decrypt(nonce, &buffer[..n]);

            if let Ok(text) = ciphertext {
                file_save.write_all(&text)?;
            } else {
                anyhow::bail!("encrypt err")
            }
        }

        anyhow::Ok(file_save_path)
    }
}
