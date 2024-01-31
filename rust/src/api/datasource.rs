use crate::process::datasource::{
    base_trait::{ClientTrait, Transfer},
    local::LocalStorage,
    s3::S3Client,
    Entry, DATASOURCES, TWODATASOURCES,
};

#[deprecated]
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

pub fn transfer_between_two_datasource(
    p: String,
    save_path: String,
    auto_encrypt: bool,
    certain_key: Option<String>,
    /* overwrite object if exists with same name, not work right now, default `false` */
    _overwrite: bool,
) -> String {
    let a = TWODATASOURCES.read().unwrap();

    let rt = tokio::runtime::Runtime::new().unwrap();

    rt.block_on(async {
        let r = (*a)
            .transfer_from_left_to_right(p, save_path, auto_encrypt, certain_key)
            .await;
        match r {
            Ok(_key) => _key,
            Err(_e) => {
                println!("error {:?}", _e);
                "error".to_owned()
            }
        }
    })
}

pub struct FMetaData {
    pub path: Option<String>,
    pub create_at: Option<i64>,
    pub md5: Option<String>,
}

pub fn check_exists(save_path: String) -> (bool, Option<FMetaData>) {
    let rt = tokio::runtime::Runtime::new().unwrap();

    let r = rt.block_on(async {
        let a = TWODATASOURCES.read().unwrap();
        if let Some(right) = &a.right {
            let right_down: &dyn ClientTrait;
            if let Some(_right) = right.as_any().downcast_ref::<S3Client>() {
                right_down = _right;
            } else {
                right_down = right.as_any().downcast_ref::<LocalStorage>().unwrap();
            }

            if let Ok(e) = right_down.get_op().is_exist(&save_path).await {
                if e {
                    let meta = right_down.get_op().stat(&save_path).await.unwrap();
                    return (
                        e,
                        Some(FMetaData {
                            path: Some(save_path.clone()),
                            create_at: Some(meta.last_modified().unwrap().timestamp()),
                            md5: Some(meta.content_md5().unwrap().to_owned()),
                        }),
                    );
                }

                return (e, None);
            }
        }
        (false, None)
    });

    r
}

pub enum DatasourcePreviewType {
    Left,
    Right,
}

pub fn get_presign_url_with_type(p: String, t: DatasourcePreviewType) -> String {
    let a = TWODATASOURCES.read().unwrap();
    match t {
        DatasourcePreviewType::Left => {
            if a.left.is_none() {
                return "".to_owned();
            }

            let rt = tokio::runtime::Runtime::new().unwrap();

            rt.block_on(async {
                if let Some(_datasource) = &a.left {
                    if let Some(_d) = _datasource.as_any().downcast_ref::<S3Client>() {
                        if let Ok(url) = _d.share(p).await {
                            return url;
                        }
                    } else {
                        return "".to_owned();
                    }
                }
                "".to_owned()
            })
        }
        DatasourcePreviewType::Right => {
            if a.right.is_none() {
                return "".to_owned();
            }

            let rt = tokio::runtime::Runtime::new().unwrap();

            rt.block_on(async {
                if let Some(_datasource) = &a.right {
                    if let Some(_d) = _datasource.as_any().downcast_ref::<S3Client>() {
                        if let Ok(url) = _d.share(p).await {
                            return url;
                        }
                    } else {
                        return "".to_owned();
                    }
                }
                "".to_owned()
            })
        }
    }
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
