import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

// ignore: constant_identifier_names
enum CachedDatasourceType { Left, Right, None }

class CachedDatasourceNotifier
    extends Notifier<Map<int, Tuple2<CachedDatasourceType, dynamic>>> {
  @override
  Map<int, Tuple2<CachedDatasourceType, dynamic>> build() {
    return {};
  }

  add(int id, Tuple2<CachedDatasourceType, dynamic> obj) {
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
