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
      height: 400,
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
              Text(account.name ?? "")
            ],
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "endpoint: ", style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.endpoint),
          ])),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "bucketname: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.bucketname),
          ])),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "accesskey: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.accesskey!.replaceRange(3, null, "***")),
          ])),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "sessionKey: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.sessionKey!.replaceRange(3, null, "***")),
          ])),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "sessionToken: ",
                style: TextStyle(color: AppStyle.appColor)),
            TextSpan(
                text: account.sessionToken == null
                    ? ""
                    : account.sessionToken!.replaceRange(3, null, "***")),
          ])),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "region: ", style: TextStyle(color: AppStyle.appColor)),
            TextSpan(text: account.region),
          ])),
        ],
      ),
    );
  }
}
