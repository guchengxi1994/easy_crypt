use crate::process::datasource::{local::LocalStorage, s3::S3Client, Entry, DATASOURCES};

pub fn transfer_from_left_to_right(
    left_index: usize,
    right_index: usize,
    p: String,
    save_path: String,
    auto_encrypt: bool,
) {
    let a = DATASOURCES.read().unwrap();

    if (*a).datasources.len() < 2 {
        return;
    }

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        let r = (*a)
            .transfer_from_left_to_right(left_index, right_index, p, save_path, auto_encrypt)
            .await;
        match r {
            Ok(_) => {}
            Err(_e) => {
                println!("error {:?}", _e)
            }
        }
    })
}

pub fn add_local_datasource(p: String) -> i64 {
    let mut a = DATASOURCES.write().unwrap();
    let client = LocalStorage::from(p).unwrap();
    (*a).datasources.push(Box::new(client));
    return (*a).datasources.len() as i64 - 1;
}

pub fn add_s3_datasource(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
) -> i64 {
    let mut a = DATASOURCES.write().unwrap();
    let client = S3Client::from(
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
    )
    .unwrap();
    (*a).datasources.push(Box::new(client));
    return (*a).datasources.len() as i64 - 1;
}

pub fn list_objects_by_index(index: usize, p: String) -> Vec<Entry> {
    let a = DATASOURCES.read().unwrap();
    if index >= (*a).datasources.len() {
        return vec![];
    }
    let datasource = (*a).datasources.get(index).unwrap();

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        if let Some(_datasource) = datasource.as_any().downcast_ref::<S3Client>() {
            return _datasource.list_objs(p).await;
        } else {
            return datasource
                .as_any()
                .downcast_ref::<LocalStorage>()
                .unwrap()
                .list_objs(p)
                .await;
        }
    })
}
