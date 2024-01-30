import 'package:easy_crypt/file_system/models/datasource_state.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: constant_identifier_names
enum CachedDatasourceType { Left, Right, None }

/// TODO 修改为只保存left和right两个数据源
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

    state.left = left;
    state = state;
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

    state.right = right;
    state = state;
  }

  // int? index(dynamic obj) {
  //   if (obj is String) {
  //     for (final i in state.entries) {
  //       if (i.value.item2.toString() == obj) {
  //         print("i.key  ${i.key}");
  //         return i.key;
  //       }
  //     }
  //   }

  //   if (obj is Datasource) {
  //     for (final i in state.entries) {
  //       if (i.value.item2 == obj) {
  //         print("i.key  ${i.key}");
  //         return i.key;
  //       }
  //     }
  //   }

  //   return null;
  // }

  // add(int id, Tuple2<CachedDatasourceType, dynamic> obj) {
  //   if (obj.item1 == CachedDatasourceType.Left) {
  //     for (final i in state.entries) {
  //       if (i.value.item1 == CachedDatasourceType.Left) {
  //         state[i.key] = Tuple2(CachedDatasourceType.None, i.value.item2);
  //       }
  //     }
  //   }

  //   if (obj.item1 == CachedDatasourceType.Right) {
  //     for (final i in state.entries) {
  //       if (i.value.item1 == CachedDatasourceType.Right) {
  //         state[i.key] = Tuple2(CachedDatasourceType.None, i.value.item2);
  //       }
  //     }
  //   }

  //   state[id] = obj;
  //   state = state;
  // }

  Datasource? findLeft() {
    return state.left;
  }

  Datasource? findRight() {
    return state.right;
  }

  // Tuple2<int, dynamic>? findRight() {
  //   for (final i in state.entries) {
  //     if (i.value.item1 == CachedDatasourceType.Right) {
  //       return Tuple2(i.key, i.value.item2);
  //     }
  //   }

  //   return null;
  // }
}

final cachedProvider =
    NotifierProvider<CachedDatasourceNotifier, CachedDatasourceState>(
  () => CachedDatasourceNotifier(),
);
