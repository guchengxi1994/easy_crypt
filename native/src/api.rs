use crate::emit::MESSAGE_SINK;
use flutter_rust_bridge::StreamSink;

pub fn test_encrypt() {
    let r = crate::tests::encrypt_file_stream();
    if let Ok(_) = r {
        println!("done");
    } else {
        println!("err {:?}", r.err());
    }
}

pub fn native_message_stream(s: StreamSink<String>) -> anyhow::Result<()> {
    let mut stream = MESSAGE_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}

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
            return "".to_owned();
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
