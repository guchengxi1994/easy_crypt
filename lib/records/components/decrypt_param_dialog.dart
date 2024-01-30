import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/records/models/decrypt_param_dialog_model.dart';
import 'package:flutter/material.dart';

class DecryptParamDialog extends StatefulWidget {
  const DecryptParamDialog({super.key, this.needsKey = true});
  final bool needsKey;

  @override
  State<DecryptParamDialog> createState() => _DecryptParamDialogState();
}

class _DecryptParamDialogState extends State<DecryptParamDialog> {
  final Color textColor = Colors.black;

  final TextEditingController keyController = TextEditingController();
  final TextEditingController fileTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool saveKey = false;

  @override
  void dispose() {
    keyController.dispose();
    fileTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        height: widget.needsKey ? 250 : 170,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                offset: const Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3,
              ),
            ]),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.needsKey) const Text("Input key"),
                if (widget.needsKey)
                  const SizedBox(
                    height: 15,
                  ),
                if (widget.needsKey)
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 250,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value == "") {
                              return "";
                            }
                            return null;
                          },
                          controller: keyController,
                          style: TextStyle(color: textColor, fontSize: 12),
                          decoration: AppStyle.inputDecoration,
                          autofocus: false,
                        ),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: saveKey,
                          onChanged: (v) {
                            if (v != null) {
                              setState(() {
                                saveKey = v;
                              });
                            }
                          }),
                      const Text("Save Key?")
                    ],
                  ),
                if (widget.needsKey)
                  const SizedBox(
                    height: 15,
                  ),
                const Text("Input filetype"),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 250,
                  height: 30,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "";
                      }
                      return null;
                    },
                    controller: fileTypeController,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: AppStyle.inputDecoration,
                    autofocus: false,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final DecryptParamDialogModel model =
                                DecryptParamDialogModel(
                                    fileType: fileTypeController.text,
                                    key: keyController.text,
                                    saveKey: saveKey);

                            Navigator.of(context).pop(model);
                          }
                        },
                        child: const Text("OK"))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
