import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  const AddAccountDialog({super.key});

  @override
  State<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog>
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
                TextButton(onPressed: () {}, child: const Text("OK"))
              ],
            )
          ],
        ),
      ),
    );
  }

  final decoration = const InputDecoration(
      hintStyle:
          TextStyle(color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
      contentPadding: EdgeInsets.only(left: 10, bottom: 15),
      border: InputBorder.none,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppStyle.appColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159))));

  final Color textColor = Colors.black;

  final TextEditingController s3nameController = TextEditingController();
  final TextEditingController s3endpointController = TextEditingController();
  final TextEditingController s3regionController = TextEditingController();
  final TextEditingController s3accessKeyController = TextEditingController();
  final TextEditingController s3sessionKeyController = TextEditingController();
  final TextEditingController s3SessionTokenController =
      TextEditingController();

  Widget _s3ConfigWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _wrapper(
              "name",
              TextField(
                controller: s3nameController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
          _wrapper(
              "endpoint",
              TextField(
                controller: s3endpointController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
          _wrapper(
              "region",
              TextField(
                controller: s3regionController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
          _wrapper(
              "access key",
              TextField(
                controller: s3accessKeyController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
          _wrapper(
              "session key",
              TextField(
                controller: s3sessionKeyController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
          _wrapper(
              "session token",
              TextField(
                controller: s3SessionTokenController,
                style: TextStyle(color: textColor, fontSize: 12),
                decoration: decoration,
              )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
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
    s3accessKeyController.dispose();
    s3endpointController.dispose();
    s3nameController.dispose();
    s3regionController.dispose();
    s3sessionKeyController.dispose();
    super.dispose();
  }
}
