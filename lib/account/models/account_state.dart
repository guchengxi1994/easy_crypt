import 'package:easy_crypt/isar/account.dart';

class AccountState {
  List<Account> accounts;

  AccountState({required this.accounts});

  AccountState copyWith({List<Account>? accounts}) {
    return AccountState(accounts: accounts ?? this.accounts);
  }
}
