import 'package:easy_crypt/account/components/add_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: "add account",
                context: context,
                pageBuilder: (c, _, __) {
                  return const Center(
                    child: AddAccountDialog(),
                  );
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
