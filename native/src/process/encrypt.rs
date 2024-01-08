use std::{
    fs::{self, File},
    io::{Read, Write},
    path::Path,
    time::{SystemTime, UNIX_EPOCH},
};

use walkdir::WalkDir;
use zip::write::FileOptions;

pub struct Enctypt {
    // maybe a list or folder
    pub file_path: Vec<String>,
    pub key: String,
    pub save_dir: String,
}

impl Enctypt {
    pub fn encrypt(&self) -> anyhow::Result<()> {
        if self.file_path.is_empty() {
            anyhow::bail!("file path is empty")
        }

        if self.file_path.len() == 1 {
            let meta = fs::metadata(self.file_path.first().unwrap())?;
            if meta.is_file() {
                // encrypt
                return anyhow::Ok(());
            }
        }

        let s = Self::compress_dir(self.file_path.clone(), self.save_dir.clone())?;
        println!("{:?}", s);
        // encrypt

        anyhow::Ok(())
    }

    fn compress_dir(paths: Vec<String>, save_dir: String) -> anyhow::Result<String> {
        let now = SystemTime::now().duration_since(UNIX_EPOCH)?.as_millis();

        let save_path = format!("{}/{}.zip", save_dir, now);
        let zipfile = File::create(&save_path)?;
        let mut zip = zip::ZipWriter::new(zipfile);
        let options = FileOptions::default()
            .compression_method(zip::CompressionMethod::Stored)
            .unix_permissions(0o755);
        let mut buffer = Vec::new();
        for p in paths {
            let meta = fs::metadata(p.clone());
            if let Ok(meta) = meta {
                if meta.is_file() {
                    let n = Path::new(&p.clone())
                        .file_name()
                        .unwrap()
                        .to_str()
                        .unwrap()
                        .to_string();
                    zip.start_file(n, options)?;
                    let mut f = File::open(&p)?;
                    f.read_to_end(&mut buffer)?;
                    zip.write_all(&*buffer)?;
                    buffer.clear();
                } else {
                    let n = Path::new(&p.clone())
                        .file_name()
                        .unwrap()
                        .to_str()
                        .unwrap()
                        .to_string();
                    zip.add_directory(n, options)?;
                    for entry in WalkDir::new(p.clone()).into_iter().filter_map(|e| e.ok()) {
                        let path = entry.path();
                        let name = path.strip_prefix(Path::new(&p.clone())).unwrap();

                        if entry.path().is_file() {
                            // let l = entry.path().display().to_string();
                            zip.start_file(Self::path_to_string(name), options)?;
                            let mut f = File::open(path)?;
                            f.read_to_end(&mut buffer)?;
                            zip.write_all(&*buffer)?;
                            buffer.clear();
                        } else {
                            zip.add_directory(Self::path_to_string(name), options)?;
                        }
                    }
                }
            }
        }

        zip.finish()?;

        anyhow::Ok(save_path)
    }

    // copied from zip writer
    fn path_to_string(path: &std::path::Path) -> String {
        let mut path_str = String::new();
        for component in path.components() {
            if let std::path::Component::Normal(os_str) = component {
                if !path_str.is_empty() {
                    path_str.push('/');
                }
                path_str.push_str(&os_str.to_string_lossy());
            }
        }
        path_str
    }
}
