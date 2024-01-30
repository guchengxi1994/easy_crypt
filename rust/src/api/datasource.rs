use crate::process::datasource::{
    local::LocalStorage, s3::S3Client, Entry, DATASOURCES, TWODATASOURCES,
};

pub fn transfer_from_left_to_right(
    left_index: usize,
    right_index: usize,
    p: String,
    save_path: String,
    auto_encrypt: bool,
) {
    let a = DATASOURCES.read().unwrap();

    if a.datasources.len() < 2 {
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

pub fn transfer_between_two_datasource(p: String, save_path: String, auto_encrypt: bool) -> String {
    let a = TWODATASOURCES.read().unwrap();

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        let r = (*a)
            .transfer_from_left_to_right(p, save_path, auto_encrypt)
            .await;
        match r {
            Ok(_key) => {
                return _key;
            }
            Err(_e) => {
                println!("error {:?}", _e);
                return "error".to_owned();
            }
        }
    })
}

pub enum DatasourcePreviewType {
    Left,
    Right,
}

pub fn add_local_datasource_with_type(p: String, t: DatasourcePreviewType) {
    let client = LocalStorage::from(p).unwrap();
    let mut a = TWODATASOURCES.write().unwrap();
    match t {
        DatasourcePreviewType::Left => {
            a.set_left(Box::new(client));
        }
        DatasourcePreviewType::Right => {
            a.set_right(Box::new(client));
        }
    }
}

pub fn add_s3_datasource_with_type(
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    t: DatasourcePreviewType,
) {
    let mut a = TWODATASOURCES.write().unwrap();
    let client = S3Client::from(
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
    )
    .unwrap();

    match t {
        DatasourcePreviewType::Left => {
            a.set_left(Box::new(client));
        }
        DatasourcePreviewType::Right => {
            a.set_right(Box::new(client));
        }
    }
}

/// TODO 将 add datasource 转为
/// 添加到一个struct 中
/// 只有 left 和 right两个参数，
/// 这样实现更加简单
#[deprecated]
pub fn add_local_datasource(p: String) -> i64 {
    let mut a = DATASOURCES.write().unwrap();
    let client = LocalStorage::from(p).unwrap();
    a.datasources.push(Box::new(client));
    a.datasources.len() as i64 - 1
}

#[deprecated]
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
    a.datasources.push(Box::new(client));
    a.datasources.len() as i64 - 1
}

#[deprecated]
pub fn list_objects_by_index(index: usize, p: String) -> Vec<Entry> {
    let a = DATASOURCES.read().unwrap();
    if index >= a.datasources.len() {
        return vec![];
    }
    let datasource = a.datasources.get(index).unwrap();

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        if let Some(_datasource) = datasource.as_any().downcast_ref::<S3Client>() {
            _datasource.list_objs(p).await
        } else {
            datasource
                .as_any()
                .downcast_ref::<LocalStorage>()
                .unwrap()
                .list_objs(p)
                .await
        }
    })
}

pub fn list_objects_left(p: String) -> Vec<Entry> {
    let a = TWODATASOURCES.read().unwrap();
    if a.left.is_none() {
        return vec![];
    }

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        if let Some(_datasource) = &a.left {
            if let Some(_d) = _datasource.as_any().downcast_ref::<S3Client>() {
                return _d.list_objs(p).await;
            } else {
                return _datasource
                    .as_any()
                    .downcast_ref::<LocalStorage>()
                    .unwrap()
                    .list_objs(p)
                    .await;
            }
        }
        vec![]
    })
}

pub fn list_objects_right(p: String) -> Vec<Entry> {
    let a = TWODATASOURCES.read().unwrap();
    if a.right.is_none() {
        return vec![];
    }

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        if let Some(_datasource) = &a.right {
            if let Some(_d) = _datasource.as_any().downcast_ref::<S3Client>() {
                return _d.list_objs(p).await;
            } else {
                return _datasource
                    .as_any()
                    .downcast_ref::<LocalStorage>()
                    .unwrap()
                    .list_objs(p)
                    .await;
            }
        }
        vec![]
    })
}
