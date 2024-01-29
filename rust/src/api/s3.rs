use std::{
    sync::{
        atomic::{AtomicBool, Ordering},
        Arc,
    },
    thread::{self, sleep},
    time::Duration,
};

use crate::{
    emit::emitter::Emitter,
    process::datasource::{base_trait::Transfer, s3::S3Client, Entry, S3CLIENT},
};

// used , remove later
pub fn init_s3_client(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
) {
    crate::process::datasource::s3::S3Client::init(
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
/// FIX DONT USE `S3CLIENT`
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

#[allow(unused_variables)]
pub fn check_account_available(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
) -> bool {
    let val = Arc::new(AtomicBool::new(false));

    let handle = thread::spawn(|| {
        sleep(Duration::from_secs(5));
    });
    let mut _val = Arc::clone(&val);
    thread::spawn(move || {
        let rt = tokio::runtime::Runtime::new().unwrap();

        let binding = rt.block_on(async {
            let client = S3Client::from(
                endpoint,
                bucketname,
                access_key,
                session_key,
                session_token,
                region,
            );

            if let Some(client) = client {
                return client.check_available().await;
            }

            false
        });
        // _val = Arc::new(AtomicBool::new(binding));
        let _ = _val.fetch_update(Ordering::SeqCst, Ordering::SeqCst, |_| Some(binding));

        println!("_val {:?}", _val);
    });

    let _ = handle.join();

    // r.load(Ordering::SeqCst)
    let r = Arc::clone(&val);
    r.load(Ordering::SeqCst)
}

#[allow(unused_assignments)]
pub fn list_objects(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    path: String,
    use_global: bool,
) -> Vec<Entry> {
    if use_global {
        let mut need_reinit: bool = false;
        {
            let client = S3CLIENT.read().unwrap();
            match (*client).as_ref() {
                Some(_c) => {
                    need_reinit = _c.access_key != access_key;
                }
                None => {
                    need_reinit = true;
                }
            }
        }

        if need_reinit {
            {
                S3Client::init(
                    endpoint,
                    bucketname,
                    access_key,
                    session_key,
                    session_token,
                    region,
                );
            }
        }

        let rt = tokio::runtime::Runtime::new().unwrap();

        let result = rt.block_on(async {
            let client = S3CLIENT.read().unwrap();

            match (*client).as_ref() {
                Some(_c) => {
                    return _c.list_objs(path).await;
                }
                None => {
                    return vec![];
                }
            }
        });

        return result;
    } else {
        let rt = tokio::runtime::Runtime::new().unwrap();
        let result = rt.block_on(async {
            let client = S3Client::from(
                endpoint,
                bucketname,
                access_key,
                session_key,
                session_token,
                region,
            );
            if let Some(_cli) = client {
                return _cli.list_objs(path).await;
            }

            return vec![];
        });
        return result;
    }
}
