use aes_gcm_siv::{aead::Aead, KeyInit, Nonce};
use std::{
    fs::{self, File},
    io::{Read, Write},
    path::Path,
    time::{SystemTime, UNIX_EPOCH},
};

use aes_gcm_siv::Aes256GcmSiv;
use walkdir::WalkDir;
use zip::write::FileOptions;

use crate::{constants::CUSTOM_HEADER, emit::emitter::Emitter};

#[derive(Debug, Clone)]
pub struct EncryptItem {
    pub file_path: String,
    pub file_id: i64,
}

#[derive(Debug, Clone)]
pub struct Enctypt {
    // maybe a list or folder
    pub items: Vec<EncryptItem>,
    pub key: String,
    pub save_dir: String,
}

impl Enctypt {
    fn get_count(&self) -> anyhow::Result<usize> {
        if self.items.is_empty() {
            return anyhow::Ok(0);
        }

        if self.items.len() == 1 {
            let meta = fs::metadata(self.items.first().unwrap().file_path.clone())?;
            if meta.is_file() {
                return anyhow::Ok(1);
            } else if meta.is_dir() {
                // is dir
                return anyhow::Ok(Self::walk_dir(
                    self.items.first().unwrap().file_path.to_string(),
                ));
            } else {
                return anyhow::Ok(0);
            }
        }

        let mut count = 0;

        for i in &self.items {
            let meta = fs::metadata(i.file_path.clone())?;
            if meta.is_file() {
                count += 1;
            } else if meta.is_dir() {
                count += Self::walk_dir(i.file_path.to_string());
            }
        }

        anyhow::Ok(count)
    }

    pub fn encrypt(&self) -> anyhow::Result<String> {
        if self.items.is_empty() {
            anyhow::bail!("file path is empty")
        }

        if self.items.len() == 1 {
            let meta = fs::metadata(self.items.first().unwrap().file_path.clone())?;
            if meta.is_file() {
                // encrypt
                let res = self.encrypt_file(
                    self.items.first().unwrap().file_path.to_string(),
                    Some(self.items.first().unwrap().file_id),
                )?;
                return anyhow::Ok(res);
            }
        }

        let s = Self::compress_dir(
            self.items.iter().map(|x| x.file_path.clone()).collect(),
            self.save_dir.clone(),
        )?;
        println!("{:?}", s);
        // encrypt
        // multi files have no id because compress into a zip file
        let res = self.encrypt_file(s, None)?;

        anyhow::Ok(res)
    }

    pub fn compress_dir(paths: Vec<String>, save_dir: String) -> anyhow::Result<String> {
        let now = SystemTime::now().duration_since(UNIX_EPOCH)?.as_millis();

        let save_path = format!("{}/{}.zip", save_dir, now);
        let zipfile = File::create(&save_path)?;
        let mut zip = zip::ZipWriter::new(zipfile);
        let options = FileOptions::default()
            .compression_method(zip::CompressionMethod::Stored)
            .unix_permissions(0o755);
        let mut buffer = Vec::new();
        let mut zip_message = crate::emit::zip_file_message::ZipFileMessage::default();
        zip_message.total = paths.len();
        for p in paths {
            let meta = fs::metadata(p.clone());
            if let Ok(meta) = meta {
                if meta.is_file() {
                    let n = Path::new(&p.clone())
                        .file_name()
                        .unwrap()
                        .to_str()
                        .unwrap()
                        .to_string();
                    zip.start_file(n, options)?;
                    let mut f = File::open(&p)?;
                    f.read_to_end(&mut buffer)?;
                    zip.write_all(&buffer)?;
                    buffer.clear();
                } else {
                    let n = Path::new(&p.clone())
                        .file_name()
                        .unwrap()
                        .to_str()
                        .unwrap()
                        .to_string();
                    zip.add_directory(n, options)?;
                    for entry in WalkDir::new(p.clone()).into_iter().filter_map(|e| e.ok()) {
                        let path = entry.path();
                        let name = path.strip_prefix(Path::new(&p.clone())).unwrap();

                        if path.is_file() {
                            // let l = entry.path().display().to_string();
                            zip.start_file(Self::path_to_string(name), options)?;
                            let mut f = File::open(path)?;
                            f.read_to_end(&mut buffer)?;
                            zip.write_all(&buffer)?;
                            buffer.clear();
                        } else {
                            zip.add_directory(Self::path_to_string(name), options)?;
                        }
                    }
                }
            }
            zip_message.current += 1;
            zip_message.current_path = p.clone();
            zip_message.send_message();
        }

        zip.finish()?;

        anyhow::Ok(save_path)
    }

    // copied from zip writer
    fn path_to_string(path: &std::path::Path) -> String {
        let mut path_str = String::new();
        for component in path.components() {
            if let std::path::Component::Normal(os_str) = component {
                if !path_str.is_empty() {
                    path_str.push('/');
                }
                path_str.push_str(&os_str.to_string_lossy());
            }
        }
        path_str
    }

    fn walk_dir(p: String) -> usize {
        let mut count = 0;
        for entry in WalkDir::new(p.clone()).into_iter().filter_map(|e| e.ok()) {
            let path = entry.path();

            if path.is_file() {
                count += 1;
            }
        }
        count
    }

    fn encrypt_file(&self, p: String, id: Option<i64>) -> anyhow::Result<String> {
        let binding = p.clone();
        let path = Path::new(&binding);
        let file_stem = path.file_stem().unwrap().to_str().unwrap();

        let file_save_path = format!("{}/{}.bin", self.save_dir, file_stem);
        let mut file = std::fs::File::open(p.clone())?;
        let mut file_save = std::fs::File::create(file_save_path.clone())?;
        let mut buffer = vec![0; crate::constants::ONE_MB.try_into().unwrap()];

        file_save.write_all(CUSTOM_HEADER.as_bytes())?;

        let cipher = Aes256GcmSiv::new(self.key.as_bytes().into());
        let nonce = Nonce::from_slice(b"_EasyCrypt__"); // 96-bits; unique per message
        let meta = fs::metadata(p.clone())?;

        let mut message = crate::emit::encrypt_message::EncryptMessage::default();
        message.total_size = meta.len();
        message.file_path = p;
        message.unique_id = id;

        while let Ok(n) = std::io::Read::read(&mut file, &mut buffer) {
            if n == 0 {
                break;
            }
            let ciphertext = cipher.encrypt(nonce, &buffer[..n]);

            if let Ok(text) = ciphertext {
                file_save.write_all(&text)?;
                message.encrypt_size += text.len() as u64;

                message.send_message();
            } else {
                anyhow::bail!("encrypt err")
            }
        }

        anyhow::Ok(file_save_path)
    }
}
