pub fn default_key() -> String {
    crate::emit::random_key_message::RandomKeyMessage::default().key
}

pub fn random_key() -> String {
    let r = crate::emit::random_key_message::RandomKeyMessage::random();
    match r {
        Ok(_r) => _r.key,
        Err(_) => crate::constants::DEFAULT_AES_KEY.to_owned(),
    }
}

pub fn encrypt(
    save_dir: String,
    files: Vec<crate::process::encrypt::EncryptItem>,
    key: String,
) -> String {
    let en = crate::process::encrypt::Enctypt {
        items: files,
        key,
        save_dir,
    };
    let s = en.encrypt();
    match s {
        Ok(_s) => _s,
        Err(e) => {
            println!("[rust] error {:?}", e);
            "".to_owned()
        }
    }
}

pub fn decrypt(
    save_dir: String,
    path: String,
    key: String,
    file_type: Option<String>,
    file_id: i64,
) -> String {
    let de = crate::process::decrypt::Decrypt {
        path,
        key,
        save_dir,
        file_type,
        file_id,
    };
    let s = de.decrypt_file();
    match s {
        Ok(_s) => _s,
        Err(e) => {
            println!("[rust] error {:?}", e);
            "".to_owned()
        }
    }
}

pub fn compress(paths: Vec<String>, save_dir: String) -> String {
    let r = crate::process::encrypt::Enctypt::compress_dir(paths, save_dir);
    match r {
        Ok(_r) => _r,
        Err(_) => "".to_owned(),
    }
}

pub fn flow_preview(operators: Vec<String>) -> Vec<String> {
    crate::process::chain::get_results(operators)
}

pub fn is_easy_encrypt_file(p: String) -> bool {
    let file = std::fs::File::open(p);
    if let Ok(file) = file {
        let r = crate::process::decrypt::Decrypt::is_easy_encrypt_file(&file);
        if let Ok(r) = r {
            return r;
        }
    }

    false
}
