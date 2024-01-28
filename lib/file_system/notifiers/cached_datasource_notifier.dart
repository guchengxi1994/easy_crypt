import 'package:easy_crypt/isar/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

// ignore: constant_identifier_names
enum CachedDatasourceType { Left, Right, None }

/// TODO 修改为只保存left和right两个数据源
class CachedDatasourceNotifier
    extends Notifier<Map<int, Tuple2<CachedDatasourceType, dynamic>>> {
  @override
  Map<int, Tuple2<CachedDatasourceType, dynamic>> build() {
    return {};
  }

  int? index(dynamic obj) {
    if (obj is String) {
      for (final i in state.entries) {
        if (i.value.item2.toString() == obj) {
          print("i.key  ${i.key}");
          return i.key;
        }
      }
    }

    if (obj is Datasource) {
      for (final i in state.entries) {
        if (i.value.item2 == obj) {
          print("i.key  ${i.key}");
          return i.key;
        }
      }
    }

    return null;
  }

  add(int id, Tuple2<CachedDatasourceType, dynamic> obj) {
    if (obj.item1 == CachedDatasourceType.Left) {
      for (final i in state.entries) {
        if (i.value.item1 == CachedDatasourceType.Left) {
          state[i.key] = Tuple2(CachedDatasourceType.None, i.value.item2);
        }
      }
    }

    if (obj.item1 == CachedDatasourceType.Right) {
      for (final i in state.entries) {
        if (i.value.item1 == CachedDatasourceType.Right) {
          state[i.key] = Tuple2(CachedDatasourceType.None, i.value.item2);
        }
      }
    }

    state[id] = obj;
    state = state;
  }

  Tuple2<int, dynamic>? findLeft() {
    for (final i in state.entries) {
      if (i.value.item1 == CachedDatasourceType.Left) {
        return Tuple2(i.key, i.value.item2);
      }
    }

    return null;
  }

  Tuple2<int, dynamic>? findRight() {
    for (final i in state.entries) {
      if (i.value.item1 == CachedDatasourceType.Right) {
        return Tuple2(i.key, i.value.item2);
      }
    }

    return null;
  }
}

final cachedProvider = NotifierProvider<CachedDatasourceNotifier,
    Map<int, Tuple2<CachedDatasourceType, dynamic>>>(
  () => CachedDatasourceNotifier(),
);
