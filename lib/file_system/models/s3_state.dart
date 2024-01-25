import 'package:easy_crypt/src/rust/api/s3.dart' as s3;
import 'package:easy_crypt/src/rust/process/transfer.dart';

class S3State {
  List<String> routers;
  List<Entry> entries;
  final String endpoint;
  final String accesskey;
  final String sessionkey;
  final String bucketname;
  final String? sessionToken;
  final String region;

  S3State(
      {this.routers = const ["/"],
      this.entries = const [],
      required this.accesskey,
      required this.bucketname,
      required this.endpoint,
      required this.sessionToken,
      required this.sessionkey,
      this.region = "cn-shanghai"});

  S3State copyWith(List<String>? routers, List<Entry>? entries) {
    return S3State(
        routers: routers ?? this.routers,
        entries: entries ?? this.entries,
        accesskey: accesskey,
        bucketname: bucketname,
        endpoint: endpoint,
        sessionToken: sessionToken,
        sessionkey: sessionkey);
  }

  Future<void> getEntry() async {
    List<Entry> entries = await s3.listObjects(
        endpoint: endpoint,
        bucketname: bucketname,
        accessKey: accesskey,
        sessionKey: sessionkey,
        region: region,
        path: routers.last,
        useGlobal: true);

    this.entries = entries;
  }
}
