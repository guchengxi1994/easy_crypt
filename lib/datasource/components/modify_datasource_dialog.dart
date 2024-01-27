import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModifyDatasourceDialog extends ConsumerStatefulWidget {
  const ModifyDatasourceDialog({super.key, required this.datasource});
  final Datasource datasource;

  @override
  ConsumerState<ModifyDatasourceDialog> createState() =>
      _ModifyDatasourceDialogState();
}

class _ModifyDatasourceDialogState
    extends ConsumerState<ModifyDatasourceDialog> {
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
            _wrapper("Type", Text(widget.datasource.datasourceType.toStr())),
            if (widget.datasource.datasourceType == DatasourceType.S3)
              _s3ConfigWidget(),
            if (widget.datasource.datasourceType == DatasourceType.Webdav)
              _webdavWidget(),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Datasource datasource = Datasource()
                          ..accesskey = s3accessKeyController.text
                          ..datasourceType = DatasourceType.S3
                          ..name = s3nameController.text
                          ..bucketname = s3bucketController.text
                          ..endpoint = s3endpointController.text
                          ..region = s3regionController.text
                          ..sessionKey = s3sessionKeyController.text
                          ..sessionToken = s3SessionTokenController.text
                          ..id = widget.datasource.id;

                        ref
                            .read(datasourceProvider.notifier)
                            .addAccount(datasource);
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

  final Color textColor = Colors.black;

  late final TextEditingController s3nameController = TextEditingController()
    ..text = widget.datasource.name ?? "";
  late final TextEditingController s3endpointController =
      TextEditingController()..text = widget.datasource.endpoint ?? "";
  late final s3endpointFocusNode = FocusNode();
  late final TextEditingController s3regionController = TextEditingController()
    ..text = widget.datasource.region ?? "";
  late final s3regionFocusNode = FocusNode();
  late final TextEditingController s3accessKeyController =
      TextEditingController()..text = widget.datasource.accesskey ?? "";
  late final s3accessKeyFocusNode = FocusNode();
  late final TextEditingController s3sessionKeyController =
      TextEditingController()..text = widget.datasource.sessionKey ?? "";
  late final s3sessionKeyFocusNode = FocusNode();
  late final TextEditingController s3SessionTokenController =
      TextEditingController()..text = widget.datasource.sessionToken ?? "";
  late final s3sessionTokenFocusNode = FocusNode();

  late final TextEditingController s3bucketController = TextEditingController()
    ..text = widget.datasource.bucketname ?? "";
  late final s3bucketFocusNode = FocusNode();

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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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
                    decoration: AppStyle.inputDecoration,
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

  final _webdavformKey = GlobalKey<FormState>();

  late final webdavNameController = TextEditingController()
    ..text = widget.datasource.name ?? "";
  final webdavUrlFocusNode = FocusNode();
  late final webdavUrlController = TextEditingController()
    ..text = widget.datasource.url ?? "";
  final webdavUsernameFocusNode = FocusNode();
  late final webdavUsernameController = TextEditingController()
    ..text = widget.datasource.username ?? "";
  final webdavPwdFocusNode = FocusNode();
  late final webdavPwdController = TextEditingController()
    ..text = widget.datasource.password ?? "";

  // tested on 坚果云
  Widget _webdavWidget() {
    return Form(
        key: _webdavformKey,
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
                    controller: webdavNameController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: AppStyle.inputDecoration,
                    autofocus: true,
                    onFieldSubmitted: (value) {
                      webdavUrlFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "url",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    controller: webdavUrlController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: AppStyle.inputDecoration,
                    focusNode: webdavUrlFocusNode,
                    onFieldSubmitted: (value) {
                      webdavUsernameFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "username",
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    controller: webdavUsernameController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: AppStyle.inputDecoration,
                    focusNode: webdavUsernameFocusNode,
                    onFieldSubmitted: (value) {
                      webdavPwdFocusNode.requestFocus();
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              _wrapper(
                  "password",
                  TextFormField(
                    focusNode: webdavPwdFocusNode,
                    controller: webdavPwdController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: AppStyle.inputDecoration,
                  )),
            ],
          ),
        ));
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

    webdavNameController.dispose();
    webdavUrlFocusNode.dispose();
    webdavUrlController.dispose();
    webdavUsernameFocusNode.dispose();
    webdavUsernameController.dispose();
    webdavPwdFocusNode.dispose();
    webdavPwdController.dispose();
    super.dispose();
  }
}
