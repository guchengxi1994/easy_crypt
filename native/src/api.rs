use crate::{
    emit::MESSAGE_SINK,
    process::transfer::{Transfer, S3CLIENT},
};
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

pub fn init_s3_client(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
) {
    crate::process::transfer::S3Client::init(
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
    );
}

/// TODO return sth.
pub fn upload_to_s3(p: String, obj: String) {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let client = S3CLIENT.read().unwrap();

        match &(*client) {
            Some(_c) => {
                let _ = _c.upload(p, obj).await;
            }
            None => {}
        }
    });
}

/// TODO return sth.
pub fn upload_to_s3_with_config(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    p: String,
    obj: String,
) {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let mut builder = opendal::services::S3::default();
        builder.endpoint(&endpoint);
        builder.bucket(&bucketname);
        builder.access_key_id(&access_key);
        builder.secret_access_key(&session_key);
        if let Some(_s) = session_token.clone() {
            builder.security_token(&_s);
        }
        builder.region(&region);

        let op = opendal::Operator::new(builder);

        match op {
            Ok(_op) => {
                let _o = _op.layer(opendal::layers::LoggingLayer::default()).finish();
                let client = crate::process::transfer::S3Client {
                    endpoint,
                    bucketname,
                    access_key,
                    session_key,
                    session_token,
                    region,
                    op: _o,
                };
                let r = client.upload(p, obj).await;

                match r {
                    Ok(_) => {}
                    Err(_e) => {
                        println!("upload error {:?}", _e);
                    }
                }
            }
            Err(_) => {
                println!("generate operator error");
            }
        }
    });
}

/// TODO return sth.
pub fn download_from_s3(p: String, obj: String) {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let client = S3CLIENT.read().unwrap();

        match &(*client) {
            Some(_c) => {
                let _ = _c.download(p, obj).await;
            }
            None => {}
        }
    });
}
