use super::{base_trait::ClientTrait, Entry, EntryType};

pub struct LocalStorage {
    pub root: String,
    pub op: opendal::Operator,
}

impl ClientTrait for LocalStorage {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }

    fn get_op(&self) -> opendal::Operator {
        self.op.clone()
    }

    fn get_name(&self) -> String {
        format!("Local {:?}", self.root)
    }
}

impl LocalStorage {
    pub fn from(path: String) -> Option<Self> {
        let mut builder = opendal::services::Fs::default();
        builder.root(&path);

        let op = opendal::Operator::new(builder);
        match op {
            Ok(_op) => {
                let _o = _op.layer(opendal::layers::LoggingLayer::default()).finish();
                Some(Self { op: _o, root: path })
            }
            Err(_) => None,
        }
    }

    pub async fn list_objs(&self, p: String) -> Vec<Entry> {
        let r = self.op.list_with(&p).await;
        match r {
            Ok(_r) => {
                let mut v = Vec::new();

                for i in _r {
                    if i.metadata().is_dir() {
                        v.push(Entry {
                            _type: EntryType::Folder,
                            path: i.path().to_owned(),
                        });
                    } else {
                        v.push(Entry {
                            _type: EntryType::File,
                            path: i.path().to_owned(),
                        });
                    }
                }

                v
            }
            Err(_) => {
                vec![]
            }
        }
    }
}
