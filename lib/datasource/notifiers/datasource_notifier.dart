import 'dart:async';

import 'package:easy_crypt/datasource/models/datasource_state.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class DatasourceNotifier extends AutoDisposeAsyncNotifier<DatasourceState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<DatasourceState> build() async {
    final datasources = await database.isar!.datasources.where().findAll();

    return DatasourceState(datasources: datasources);
  }

  addDatasource(Datasource a) async {
    state = const AsyncLoading();
    await database.isar!.writeTxn(() async {
      await database.isar!.datasources.put(a);
    });

    state = await AsyncValue.guard(() async {
      // final l = state.value!.accounts..add(a);
      final accounts = await database.isar!.datasources.where().findAll();
      return DatasourceState(datasources: accounts);
    });
  }

  List<Datasource> getS3() {
    return state.value!.datasources
        .where((element) => element.datasourceType == DatasourceType.S3)
        .toList();
  }

  removeDatasource(Datasource a) async {
    state = const AsyncLoading();
    await database.isar!.writeTxn(() async {
      await database.isar!.datasources.delete(a.id);
    });

    state = await AsyncValue.guard(() async {
      final l = state.value!.datasources..remove(a);
      return DatasourceState(datasources: l);
    });
  }
}

final datasourceProvider =
    AutoDisposeAsyncNotifierProvider<DatasourceNotifier, DatasourceState>(
        () => DatasourceNotifier());
