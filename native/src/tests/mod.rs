use std::io::Write;

use aes_gcm_siv::{
    aead::{Aead, KeyInit},
    Aes256GcmSiv,
    Nonce, // Or `Aes128GcmSiv`
};

pub fn encrypt_file_stream() -> anyhow::Result<()> {
    let file_path = "D:/FlutterKanbanBoard-main.zip";
    let file_save_path = "result.bin";
    let size = 1024 * 1024;
    let mut file = std::fs::File::open(file_path)?;
    let mut file_save = std::fs::File::create(file_save_path)?;
    let mut buffer = vec![0; size];

    let cipher = Aes256GcmSiv::new(
        (&[
            116, 205, 234, 41, 154, 80, 234, 206, 204, 195, 229, 49, 9, 224, 207, 115, 206, 194,
            116, 83, 254, 168, 87, 207, 101, 218, 19, 218, 240, 95, 234, 96,
        ])
            .into(),
    );
    let nonce = Nonce::from_slice(b"unique nonce"); // 96-bits; unique per message

    while let Ok(n) = std::io::Read::read(&mut file, &mut buffer) {
        if n == 0 {
            break;
        }
        println!("size {:?}", n);
        let ciphertext = cipher.encrypt(nonce, &buffer[..n]);

        if let Ok(text) = ciphertext {
            println!("encrypt size {:?}", text.len());
            file_save.write_all(&text)?;
        } else {
            anyhow::bail!("encrypt err")
        }
    }

    anyhow::Ok(())
}

#[allow(unused_imports)]
mod tests {
    use std::io::Write;

    use aes_gcm_siv::{
        aead::{Aead, KeyInit, OsRng},
        Aes256GcmSiv,
        Nonce, // Or `Aes128GcmSiv`
    };

    use crate::emit;

    #[test]
    fn key() {
        let key = Aes256GcmSiv::generate_key(&mut OsRng);
        println!("{:?}", key)
    }

    #[test]
    fn encrypt_file_stream() -> anyhow::Result<()> {
        let file_path = "D:/FlutterKanbanBoard-main.zip";
        let file_save_path = "result.bin";
        let size = 1024 * 1024;
        let mut file = std::fs::File::open(file_path)?;
        let mut file_save = std::fs::File::create(file_save_path)?;
        let mut buffer = vec![0; size];

        // let key = Aes256GcmSiv::generate_key(&mut OsRng);
        let cipher = Aes256GcmSiv::new(
            (&[
                116, 205, 234, 41, 154, 80, 234, 206, 204, 195, 229, 49, 9, 224, 207, 115, 206,
                194, 116, 83, 254, 168, 87, 207, 101, 218, 19, 218, 240, 95, 234, 96,
            ])
                .into(),
        );
        let nonce = Nonce::from_slice(b"unique nonce"); // 96-bits; unique per message

        while let Ok(n) = std::io::Read::read(&mut file, &mut buffer) {
            if n == 0 {
                break;
            }
            println!("size {:?}", n);
            let ciphertext = cipher.encrypt(nonce, &buffer[..n]);

            if let Ok(text) = ciphertext {
                println!("encrypt size {:?}", text.len());
                file_save.write_all(&text)?;
            } else {
                anyhow::bail!("encrypt err")
            }
        }

        anyhow::Ok(())
    }

    #[test]
    fn decrypt_file_stream() -> anyhow::Result<()> {
        let file_path = "result.bin";
        let file_save_path = "decrypt_result.zip";
        let size = 1048592;
        let mut file = std::fs::File::open(file_path)?;
        let mut file_save = std::fs::File::create(file_save_path)?;
        let mut buffer = vec![0; size];

        let cipher = Aes256GcmSiv::new(
            (&[
                116, 205, 234, 41, 154, 80, 234, 206, 204, 195, 229, 49, 9, 224, 207, 115, 206,
                194, 116, 83, 254, 168, 87, 207, 101, 218, 19, 218, 240, 95, 234, 96,
            ])
                .into(),
        );
        let nonce = Nonce::from_slice(b"unique nonce"); // 96-bits; unique per message

        while let Ok(n) = std::io::Read::read(&mut file, &mut buffer) {
            if n == 0 {
                break;
            }
            println!("size {:?}", n);
            let ciphertext = cipher.decrypt(nonce, &buffer[..n]);

            if let Ok(text) = ciphertext {
                println!("decrypt size {:?}", text.len());
                file_save.write_all(&text)?;
            } else {
                anyhow::bail!("decrypt err {:?}", ciphertext.err())
            }
        }

        anyhow::Ok(())
    }

    #[test]
    fn default_key_test() {
        let k = crate::emit::random_key_message::RandomKeyMessage::default();
        let v = k.get_key();
        assert!(v.len() == 32);
        let s = String::from_utf8(v.to_vec()).unwrap();
        assert!(s == crate::constants::DEFAULT_AES_KEY)
    }

    #[test]
    fn test_zip() {
        let en = crate::process::encrypt::Enctypt {
            items: [crate::process::encrypt::EncryptItem {
                file_id: 0,
                file_path: r"D:\github_repo\easy_crypt\lib".to_string(),
            }]
            .to_vec(),
            key: crate::emit::random_key_message::RandomKeyMessage::default().key,
            save_dir: r"D:\github_repo\easy_crypt\native".to_owned(),
        };

        let r = en.encrypt();
        match r {
            Ok(_) => {}
            Err(e) => {
                println!("error {:?}", e)
            }
        }
    }

    #[test]
    fn test_zip_multi_entry() {
        let en = crate::process::encrypt::Enctypt {
            items: [
                crate::process::encrypt::EncryptItem {
                    file_id: 0,
                    file_path: r"D:\github_repo\easy_crypt\lib".to_string(),
                },
                crate::process::encrypt::EncryptItem {
                    file_id: 1,
                    file_path: r"C:\Users\xiaoshuyui\Desktop\无标题-2023-02-27-0936.png"
                        .to_string(),
                },
            ]
            .to_vec(),
            key: crate::emit::random_key_message::RandomKeyMessage::default().key,
            save_dir: r"D:\github_repo\easy_crypt\native".to_owned(),
        };

        let r = en.encrypt();
        match r {
            Ok(_) => {}
            Err(e) => {
                println!("error {:?}", e)
            }
        }
    }

    #[test]
    fn test_encrypt2() {
        let k = crate::emit::random_key_message::RandomKeyMessage::random();
        match k {
            Ok(_k) => {
                let en = crate::process::encrypt::Enctypt {
                    items: [crate::process::encrypt::EncryptItem {
                        file_id: 0,
                        file_path: r"C:\Users\xiaoshuyui\Documents\data_base.isar".to_owned(),
                    }]
                    .to_vec(),
                    key: _k.key,
                    save_dir: r"D:\github_repo\easy_crypt\build\windows\x64\runner\Debug\cache"
                        .to_owned(),
                };
                let s = en.encrypt();
                match s {
                    Ok(_s) => {
                        println!("{:?}", _s);
                    }
                    Err(e) => {
                        println!("[rust] error {:?}", e);
                    }
                }
            }
            Err(_e) => {
                println!("error {:?}", _e);
            }
        }
    }
}
