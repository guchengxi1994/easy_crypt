use crate::{
    emit::{emitter::Emitter, MESSAGE_SINK}, frb_generated::StreamSink, process::transfer::{S3Client, Transfer, S3CLIENT}
};


#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}




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
        let mut message =
            crate::emit::file_transfer_message::FileTransferMessage::new(p.clone()).unwrap();
        match &(*client) {
            Some(_c) => {
                let _ = _c.upload(p, obj, &mut message).await;
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
        let client = S3Client::from(
            endpoint,
            bucketname,
            access_key,
            session_key,
            session_token,
            region,
        );
        if let Some(_cli) = client {
            // let r = client.upload(p, obj, &mut message).await;
            if let Ok(mut message) =
                crate::emit::file_transfer_message::FileTransferMessage::new(p.clone())
            {
                let r = _cli.upload(p, obj, &mut message).await;

                match r {
                    Ok(_) => {}
                    Err(_e) => {
                        message.error_msg = Some("upload error".to_owned());
                        message.send_message();
                        println!("upload error {:?}", _e);
                    }
                }
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

pub fn generate_pregisn_url(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    obj: String,
) -> Option<String> {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let client = S3Client::from(
            endpoint,
            bucketname,
            access_key,
            session_key,
            session_token,
            region,
        );

        if let Some(_cli) = client {
            let url = _cli.share(obj).await;
            match url {
                Ok(_url) => Some(_url),
                Err(_) => None,
            };
        }

        None
    })
}
