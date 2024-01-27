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
    use std::{
        fs::File,
        io::{Read, Write},
        sync::Mutex,
        time::{Duration, SystemTime, UNIX_EPOCH},
    };

    use aes_gcm_siv::{
        aead::{Aead, KeyInit, OsRng},
        Aes256GcmSiv,
        Nonce, // Or `Aes128GcmSiv`
    };
    use once_cell::sync::Lazy;
    use opendal::{raw::oio::ReadExt, EntryMode};
    use tokio::io::AsyncWriteExt;
    // use opendal::services::S3;

    use crate::{
        emit::{self, emitter::Emitter},
        process::datasource::{local::LocalStorage, s3::S3Client, DATASOURCES},
    };

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

    static MINIO_OPERATOR_HOME: Lazy<Mutex<opendal::Operator>> = Lazy::new(|| {
        let mut builder = opendal::services::S3::default();
        builder.endpoint("http://127.0.0.1:9000");
        builder.bucket("xiaoshuyui");
        builder.access_key_id("nAPrblNJQUzF76NWTNMt");
        builder.secret_access_key("luSfM0DDSgPEQz63Pu6U5mWFTMAU7Hy5c1xIMWlM");
        builder.region("cn-shanghai");
        let op = opendal::Operator::new(builder)
            .unwrap()
            // Init with logging layer enabled.
            .layer(opendal::layers::LoggingLayer::default())
            .finish();

        Mutex::new(op)
    });

    #[tokio::test]
    async fn opendal_minio_home_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR_HOME.lock().unwrap()).clone();
        }

        // Fetch this file's metadata
        let meta = op.stat("199_S.jpg").await?;
        let length = meta.content_length();

        println!("length  {:?}", length);

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn opendal_minio_home_presign_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR_HOME.lock().unwrap()).clone();
        }

        // Fetch this file's presign_url
        let presign = op
            .presign_read("199_S.jpg", Duration::from_secs(3600))
            .await?;

        println!("presign  {:?}", presign);

        anyhow::Ok(())
    }

    static MINIO_OPERATOR: Lazy<Mutex<opendal::Operator>> = Lazy::new(|| {
        let mut builder = opendal::services::S3::default();
        builder.endpoint("http://127.0.0.1:9000");
        builder.bucket("xiaoshuyuilocaltest");
        builder.access_key_id("P11IMlEYNgclY8R1");
        builder.secret_access_key("xZaK6RsJTlWOPyjmNXgja8KcDx8R5loH");
        builder.region("cn-shanghai");

        let op = opendal::Operator::new(builder)
            .unwrap()
            // Init with logging layer enabled.
            .layer(opendal::layers::LoggingLayer::default())
            .finish();

        Mutex::new(op)
    });

    #[tokio::test]
    async fn opendal_minio_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR.lock().unwrap()).clone();
        }

        // Fetch this file's metadata
        let meta = op.stat("demo.pdf").await?;
        let length = meta.content_length();

        println!("length  {:?}", length);

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn opendal_minio_list_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR.lock().unwrap()).clone();
        }

        let r = op.list_with("/").await?;

        println!("{:?}", r.len());

        for entry in r {
            match entry.metadata().mode() {
                EntryMode::FILE => {
                    println!("Handling file")
                }
                EntryMode::DIR => {
                    println!("Handling dir {}", entry.path())
                }
                EntryMode::Unknown => continue,
            }
        }

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn opendal_minio_upload_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR.lock().unwrap()).clone();
        }

        let mut message = crate::emit::file_transfer_message::FileTransferMessage::new(
            r"D:\minio\minio.exe".to_owned(),
        )?;

        let mut writer = op.writer("minio.bin").await?;

        let mut file = File::open(r"D:\minio\minio.exe")?;
        let mut buffer = vec![0; 16 * 1024 * 1024]; // 16MB
        let mut transfered = 0;

        loop {
            let count = std::io::Read::read(&mut file, &mut buffer)?;
            if count == 0 {
                break;
            }

            writer.write(buffer[..count].to_vec()).await?;

            let duration = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs()
                - message.get_start_time();
            transfered += count;
            if duration > 0 {
                let speed = (transfered as f64) / (duration as f64);
                message.set_speed(speed);
            }

            println!("duration : {} , json {:?}", duration, message);
        }

        writer.close().await?;

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn opendal_minio_download_test() -> anyhow::Result<()> {
        let op;

        {
            op = (*MINIO_OPERATOR.lock().unwrap()).clone();
        }

        let mut message = crate::emit::file_transfer_message::FileTransferMessage::new(
            r"D:\github_repo\easy_crypt\native\minio.bin".to_owned(),
        )?;

        let mut reader = op.reader("minio.bin").await?;

        // let mut file = File::open(r"D:\github_repo\easy_crypt\native\minio.bin")?;
        let mut file_save = std::fs::File::create(r"D:\github_repo\easy_crypt\native\minio.bin")?;
        let mut buffer = vec![0; 16 * 1024 * 1024]; // 16MB
        let mut transfered = 0;

        loop {
            let count = reader.read(&mut buffer).await?;
            if count == 0 {
                break;
            }

            file_save.write_all(&buffer[..count])?;

            let duration = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs()
                - message.get_start_time();
            transfered += count;
            if duration > 0 {
                let speed = (transfered as f64) / (duration as f64);
                message.set_speed(speed);
            }

            println!("duration : {} , json {:?}", duration, message);
        }

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn opendal_local_test() -> anyhow::Result<()> {
        let mut builder = opendal::services::Fs::default();
        builder.root("D:/AppFlowy");
        let op = opendal::Operator::new(builder)?.finish();

        let r = op.list_with("/").await?;

        println!("{:?}", r.len());

        for entry in r {
            match entry.metadata().mode() {
                EntryMode::FILE => {
                    println!("Handling file")
                }
                EntryMode::DIR => {
                    println!("Handling dir {}", entry.path())
                }
                EntryMode::Unknown => continue,
            }
        }

        anyhow::Ok(())
    }

    #[tokio::test]
    async fn test_cache_datasources() -> anyhow::Result<()> {
        {
            let mut a = DATASOURCES.write().unwrap();

            let client1 = LocalStorage::from(r"D:\github_repo".to_owned()).unwrap();
            let client2 = S3Client::from(
                "http://127.0.0.1:9000".to_owned(),
                "xiaoshuyui".to_owned(),
                "nAPrblNJQUzF76NWTNMt".to_owned(),
                "luSfM0DDSgPEQz63Pu6U5mWFTMAU7Hy5c1xIMWlM".to_owned(),
                None,
                "cn-shanghai".to_owned(),
            )
            .unwrap();

            (*a).datasources.push(Box::new(client1));
            (*a).datasources.push(Box::new(client2));
        }

        {
            let a = DATASOURCES.read().unwrap();
            let left = (*a).datasources.first().unwrap();
            let right = (*a).datasources.last().unwrap();

            let left_down = left.as_any().downcast_ref::<LocalStorage>().unwrap();
            let right_down = right.as_any().downcast_ref::<S3Client>().unwrap();

            let r = left_down.op.list_with("/").await?;

            println!("{:?}", r.len());

            for entry in r {
                match entry.metadata().mode() {
                    EntryMode::FILE => {
                        println!("Handling file")
                    }
                    EntryMode::DIR => {
                        println!("Handling dir {}", entry.path())
                    }
                    EntryMode::Unknown => continue,
                }
            }

            println!("===============================================================");

            let r = right_down.op.list_with("/").await?;

            println!("{:?}", r.len());

            for entry in r {
                match entry.metadata().mode() {
                    EntryMode::FILE => {
                        println!("Handling file")
                    }
                    EntryMode::DIR => {
                        println!("Handling dir {}", entry.path())
                    }
                    EntryMode::Unknown => continue,
                }
            }
        }

        anyhow::Ok(())
    }
}
