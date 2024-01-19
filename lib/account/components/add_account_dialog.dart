import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/isar/account.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountDialog extends ConsumerStatefulWidget {
  const AddAccountDialog({super.key});

  @override
  ConsumerState<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<AddAccountDialog>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 0.8 * MediaQuery.of(context).size.width,
        height: 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            _wrapper(
                "Type",
                TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: const [
                      Tab(
                        child: Text("S3"),
                      ),
                      Tab(
                        child: Text("Webdav"),
                      ),
                    ])),
            Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                  _s3ConfigWidget(),
                  const Center(
                    child: Text("Webdav"),
                  ),
                ])),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Account account = Account()
                          ..accesskey = s3accessKeyController.text
                          ..accountType = AccountType.S3
                          ..name = s3nameController.text
                          ..bucketname = s3bucketController.text
                          ..endpoint = s3endpointController.text
                          ..region = s3regionController.text
                          ..sessionKey = s3sessionKeyController.text
                          ..sessionToken = s3SessionTokenController.text;

                        ref.read(accountProvider.notifier).addAccount(account);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("OK"))
              ],
            )
          ],
        ),
      ),
    );
  }

  final decoration = const InputDecoration(
      errorStyle: TextStyle(height: 0),
      hintStyle:
          TextStyle(color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
      contentPadding: EdgeInsets.only(left: 10, bottom: 15),
      border: InputBorder.none,
      // focusedErrorBorder:
      //     OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppStyle.appColor)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppStyle.appColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159))));

  final Color textColor = Colors.black;

  final TextEditingController s3nameController = TextEditingController();
  final TextEditingController s3endpointController = TextEditingController();
  final s3endpointFocusNode = FocusNode();
  final TextEditingController s3regionController = TextEditingController();
  final s3regionFocusNode = FocusNode();
  final TextEditingController s3accessKeyController = TextEditingController();
  final s3accessKeyFocusNode = FocusNode();
  final TextEditingController s3sessionKeyController = TextEditingController();
  final s3sessionKeyFocusNode = FocusNode();
  final TextEditingController s3SessionTokenController =
      TextEditingController();
  final s3sessionTokenFocusNode = FocusNode();

  final TextEditingController s3bucketController = TextEditingController();
  final s3bucketFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  Widget _s3ConfigWidget() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _wrapper(
                  "name",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    controller: s3nameController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    autofocus: true,
                    onFieldSubmitted: (value) {
                      s3endpointFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "endpoint",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    focusNode: s3endpointFocusNode,
                    controller: s3endpointController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    onFieldSubmitted: (value) {
                      s3regionFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "region",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    focusNode: s3regionFocusNode,
                    controller: s3regionController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    onFieldSubmitted: (value) {
                      s3accessKeyFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "access key",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    focusNode: s3accessKeyFocusNode,
                    controller: s3accessKeyController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    onFieldSubmitted: (value) {
                      s3sessionKeyFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "session key",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    focusNode: s3sessionKeyFocusNode,
                    controller: s3sessionKeyController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    onFieldSubmitted: (value) {
                      s3bucketFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "bucket name",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    focusNode: s3bucketFocusNode,
                    controller: s3bucketController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                    onFieldSubmitted: (value) {
                      s3sessionTokenFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "session token",
                  TextFormField(
                    focusNode: s3sessionTokenFocusNode,
                    controller: s3SessionTokenController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: decoration,
                  )),
            ],
          ),
        ));
  }

  _wrapper(String title, Widget child) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(title),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: child,
        ))
      ],
    );
  }

  @override
  void dispose() {
    s3SessionTokenController.dispose();
    s3sessionTokenFocusNode.dispose();
    s3accessKeyController.dispose();
    s3accessKeyFocusNode.dispose();
    s3endpointController.dispose();
    s3endpointFocusNode.dispose();
    s3nameController.dispose();
    s3regionController.dispose();
    s3regionFocusNode.dispose();
    s3sessionKeyController.dispose();
    s3sessionKeyFocusNode.dispose();
    s3bucketController.dispose();
    s3bucketFocusNode.dispose();
    super.dispose();
  }
}
