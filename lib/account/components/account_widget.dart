import 'package:easy_crypt/account/components/modify_account_dialog.dart';
import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/isar/account.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountWidget extends ConsumerWidget {
  const AccountWidget({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      height: 350,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all()),
                width: 40,
                height: 40,
                child: const Center(
                  child: Icon(Icons.storage),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                account.name ?? "",
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              InkWell(
                child: const Icon(
                  Icons.change_circle,
                  color: Colors.green,
                ),
                onTap: () {
                  showGeneralDialog(
                      barrierDismissible: true,
                      barrierLabel: "modify",
                      context: context,
                      pageBuilder: (c, _, __) {
                        return Center(
                          child: ModifyAccountDialog(account: account),
                        );
                      });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  ref.read(accountProvider.notifier).removeAccount(account);
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "endpoint: ", style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.endpoint),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "bucketname: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.bucketname),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "accesskey: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.accesskey!.replaceRange(3, null, "***")),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "sessionKey: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.sessionKey!.replaceRange(3, null, "***")),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "sessionToken: ",
                style: TextStyle(color: AppStyle.appColor)),
            if (account.sessionToken == null || account.sessionToken == "")
              const TextSpan(
                  text: "(It is better to have a session token)",
                  style: TextStyle(color: Colors.amberAccent)),
            if (account.sessionToken != null &&
                account.sessionToken != "" &&
                account.sessionToken!.length > 5)
              TextSpan(
                  text: account.sessionToken!.replaceRange(3, null, "***")),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "region: ", style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.region),
          ])),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "type: ", style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.accountType.toStr()),
          ])),
        ],
      ),
    );
  }
}
