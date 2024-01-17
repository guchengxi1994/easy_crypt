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

    #[allow(dead_code)]
    fn encrypt(data: &Vec<u8>, key: &Vec<u8>) -> Vec<u8> {
        data.iter()
            .zip(key.iter())
            .map(|(&x1, &x2)| x1 ^ x2)
            .collect()
    }

    #[allow(dead_code)]
    fn decrypt(data: &Vec<u8>, key: &Vec<u8>) -> Vec<u8> {
        data.iter()
            .zip(key.iter())
            .map(|(&x1, &x2)| x1 ^ x2)
            .collect()
    }

    #[test]
    fn cumtom() {
        let data: Vec<u8> = "abc123ghj6".to_string().into_bytes();
        // let key: Vec<u8> = vec![0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10]; // 这是一个示例密钥

        let key: Vec<u8> = "rfgbh12345".to_string().into_bytes(); // 这是一个示例密钥

        println!("明文: {:?}", data);

        let encrypted_data = encrypt(&data, &key);
        println!("密文: {:?}", encrypted_data);

        let decrypted_data = decrypt(&encrypted_data, &key);
        println!("解密后的明文: {:?}", String::from_utf8(decrypted_data));
    }

    #[test]
    fn cumtom2() {
        let data: Vec<u8> = "abc123ghj6".to_string().into_bytes();
        // let key: Vec<u8> = vec![0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10]; // 这是一个示例密钥

        println!("明文: {:?}", data);

        let encrypted_data: Vec<u8> = data.iter().map(|x| !x).collect();
        println!("密文: {:?}", encrypted_data);

        let decrypted_data: Vec<u8> = encrypted_data.iter().map(|x| !x).collect();
        println!("解密后的明文: {:?}", String::from_utf8(decrypted_data));
    }

    // not eq
    #[test]
    fn cumtom3() {
        let data: Vec<u8> = "abc123ghj6".to_string().into_bytes();
        let key: Vec<u8> = vec![0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10]; // 这是一个示例密钥

        println!("明文: {:?}", data);

        let encrypted_data: Vec<u8> = data.iter().zip(key.iter()).map(|(x, k)| x | k).collect();
        println!("密文: {:?}", String::from_utf8(encrypted_data.clone()));

        let decrypted_data: Vec<u8> = encrypted_data
            .iter()
            .zip(key.iter())
            .map(|(x, k)| x & !k)
            .collect();
        println!("解密后的明文: {:?}", String::from_utf8(decrypted_data));
    }

    #[test]
    fn test_chain() {
        let c = crate::process::operator::xor_operator::XOROperator {
            key: "rfgbh12345".to_string().into_bytes(),
        };

        let c2 = crate::process::operator::not_operator::NotOperator {};

        let c3 = crate::process::operator::aes_operator::AesOperator::default();

        let mut chain = crate::process::chain::Chain::default();

        chain.add_encrypt_operator(Box::new(c));
        chain.add_encrypt_operator(Box::new(c2));
        chain.add_encrypt_operator(Box::new(c3));

        let r = chain.encrypt();

        println!("{:?}", r);

        let result = chain.decrypt();

        println!("{:?}", String::from_utf8(result));
    }

    #[tokio::test]
    async fn opendal_minio_home_test() -> anyhow::Result<()> {
        let mut builder = opendal::services::S3::default();
        builder.endpoint("http://127.0.0.1:9000");
        builder.bucket("xiaoshuyui");
        builder.access_key_id("nAPrblNJQUzF76NWTNMt");
        builder.secret_access_key("luSfM0DDSgPEQz63Pu6U5mWFTMAU7Hy5c1xIMWlM");
        builder.region("cn-shanghai");
        let op = opendal::Operator::new(builder)?
            // Init with logging layer enabled.
            .layer(opendal::layers::LoggingLayer::default())
            .finish();

        // Fetch this file's metadata
        let meta = op.stat("199_S.jpg").await?;
        let length = meta.content_length();

        println!("length  {:?}", length);

        anyhow::Ok(())
    }
}
