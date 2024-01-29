use async_trait::async_trait;

#[async_trait]
pub trait Transfer {
    /*
        `upload`
        p:                  file path
        object_path:        s3/webdav/... storage path
        message:            message send to dart
    */
    async fn upload(
        &self,
        p: String,
        object_path: String,
        message: &mut crate::emit::file_transfer_message::FileTransferMessage,
    ) -> anyhow::Result<()>;

    // TODO add `message`
    async fn download(&self, p: String, object_path: String) -> anyhow::Result<()>;

    /*
        pregisn url for S3
        whatever for others
    */
    async fn share(&self, object_path: String) -> anyhow::Result<String>;
}

pub trait ClientTrait {
    fn as_any(&self) -> &dyn std::any::Any;

    fn get_op(&self) -> opendal::Operator;

    fn get_name(&self) -> String;

    // async fn list_objects(&self, p: String) -> Vec<Entry>;
}
