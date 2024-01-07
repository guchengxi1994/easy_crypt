#[allow(unused_imports)]
mod tests {

    use std::io::Write;

    use aes_gcm_siv::{
        aead::{Aead, KeyInit, OsRng},
        Aes256GcmSiv,
        Nonce, // Or `Aes128GcmSiv`
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
}
