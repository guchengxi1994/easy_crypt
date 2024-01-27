import 'package:flutter_riverpod/flutter_riverpod.dart';

class CachedDatasourceNotifier extends Notifier<Map<int, dynamic>> {
  @override
  Map<int, dynamic> build() {
    return {};
  }

  add(int id, dynamic obj) {
    state[id] = obj;
    state = state;
  }
}

final cachedProvider =
    NotifierProvider<CachedDatasourceNotifier, Map<int, dynamic>>(
  () => CachedDatasourceNotifier(),
);
