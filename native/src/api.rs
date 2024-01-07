pub fn test_encrypt() {
    let r = crate::tests::encrypt_file_stream();
    if let Ok(_) = r {
        println!("done");
    } else {
        println!("err {:?}", r.err());
    }
}
