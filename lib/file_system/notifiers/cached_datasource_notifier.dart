import 'package:easy_crypt/file_system/models/datasource_state.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: constant_identifier_names
enum CachedDatasourceType { Left, Right, None }

class CachedDatasourceNotifier extends Notifier<CachedDatasourceState> {
  @override
  CachedDatasourceState build() {
    return CachedDatasourceState(left: null, right: null);
  }

  setLeft(Datasource left) async {
    if (left.datasourceType == DatasourceType.Local) {
      await addLocalDatasourceWithType(
          p: left.localConfig!.path ?? "", t: DatasourcePreviewType.left);
    } else if (left.datasourceType == DatasourceType.S3) {
      await addS3DatasourceWithType(
          endpoint: left.s3config!.endpoint!,
          t: DatasourcePreviewType.left,
          bucketname: left.s3config!.bucketname!,
          accessKey: left.s3config!.accesskey!,
          sessionKey: left.s3config!.sessionKey!,
          region: left.s3config!.region!,
          sessionToken: left.s3config!.sessionToken);
    }

    state = state.copyWith(left, null);
  }

  setRight(Datasource right) async {
    if (right.datasourceType == DatasourceType.Local) {
      await addLocalDatasourceWithType(
          p: right.localConfig!.path ?? "", t: DatasourcePreviewType.right);
    } else if (right.datasourceType == DatasourceType.S3) {
      await addS3DatasourceWithType(
          endpoint: right.s3config!.endpoint!,
          t: DatasourcePreviewType.right,
          bucketname: right.s3config!.bucketname!,
          accessKey: right.s3config!.accesskey!,
          sessionKey: right.s3config!.sessionKey!,
          region: right.s3config!.region!,
          sessionToken: right.s3config!.sessionToken);
    }

    state = state.copyWith(null, right);
  }

  Datasource? findLeft() {
    return state.left;
  }

  Datasource? findRight() {
    return state.right;
  }
}

final cachedProvider =
    NotifierProvider<CachedDatasourceNotifier, CachedDatasourceState>(
  () => CachedDatasourceNotifier(),
);
