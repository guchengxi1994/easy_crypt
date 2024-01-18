import 'dart:async';

import 'package:easy_crypt/account/models/account_state.dart';
import 'package:easy_crypt/isar/account.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class AccountNotifier extends AutoDisposeAsyncNotifier<AccountState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<AccountState> build() async {
    final accounts = await database.isar!.accounts.where().findAll();

    return AccountState(accounts: accounts);
  }

  addAccount(Account a) async {
    state = const AsyncLoading();
    await database.isar!.writeTxn(() async {
      await database.isar!.accounts.put(a);
    });

    state = await AsyncValue.guard(() async {
      final l = state.value!.accounts..add(a);
      return AccountState(accounts: l);
    });
  }
}

final accountProvider =
    AutoDisposeAsyncNotifierProvider<AccountNotifier, AccountState>(
        () => AccountNotifier());
