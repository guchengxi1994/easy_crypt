// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

part 'datasource.g.dart';

enum DatasourceType { S3, Webdav, Local }

extension ToString on DatasourceType {
  String toStr() {
    switch (this) {
      case DatasourceType.S3:
        return "S3";
      case DatasourceType.Webdav:
        return "Webdav";
      case DatasourceType.Local:
        return "Local";
    }
  }
}

@collection
class Datasource {
  @enumerated
  late DatasourceType datasourceType;
  String? name;

  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  /* S3 config */
  String? endpoint;
  String? bucketname;
  String? accesskey;
  String? sessionKey;
  String? sessionToken;
  String? region;

  /* webdav config */
  String? url;
  String? username;
  String? password;

  /* local */
  String? path;

  @override
  bool operator ==(Object other) {
    if (other is! Datasource) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
