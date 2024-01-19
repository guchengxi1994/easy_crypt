import 'dart:convert';

import 'package:easy_crypt/account/account_screen.dart';
import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/customize_flow/flow_screen.dart';
import 'package:easy_crypt/layout/components/jobs_box.dart';
import 'package:easy_crypt/layout/models/job_state.dart';
import 'package:easy_crypt/layout/notifiers/job_notifier.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:easy_crypt/workboard/workboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'notifiers/expand_collapse_notifier.dart';
import 'notifiers/navigator_notifier.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

const double minWidth = 70;
const double maxWidth = 200;

class _LayoutState extends ConsumerState<Layout> with TickerProviderStateMixin {
  final stream = api.nativeMessageStream();

  late final notifier =
      ExpandCollapseNotifier(minWidth: minWidth, maxWidth: maxWidth);

  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;

  bool isExpanded = false;

  _toggleSidemenu() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    // print("stream.isBroadcast  ${stream.isBroadcast}");   // ----> false <----
    stream.listen((event) {
      logger.info(event);
      final j = jsonDecode(event);
      if (j["type"] == 2) {
        ref.read(encryptRecordsProvider.notifier).changeProgress(
            j["unique_id"], j["encrypt_size"] / j["total_size"]);
      } else if (j["type"] == 3) {
      } else if (j['type'] == 4) {
        UploadJob uploadJob = UploadJob.fromJson(j);
        ref.read(jobProvider.notifier).update(uploadJob);
      }
    });

    notifier.addListener(() => mounted ? setState(() {}) : null);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation =
        _controller.drive(Tween<double>(begin: minWidth, end: maxWidth));
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(accountProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppStyle.appbarHeight),
        child: WindowCaption(
          brightness: Brightness.light,
          backgroundColor: AppStyle.appColor,
          title: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
              ),
            ],
          ),
        ),
      ),
      // body: const Workboard(),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                color: AppStyle.appColor,
                child: NavigationRail(
                  onDestinationSelected: (value) {
                    ref.read(pageNavigator.notifier).changeState(value);
                  },
                  backgroundColor: Colors.transparent,
                  destinations: [
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.security,
                        ),
                        label: const Text("Encrypt"),
                        selectedIcon: Icon(
                          Icons.security,
                          color: AppStyle.appColor.withGreen(100),
                        )),
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.abc,
                        ),
                        label: const Text("Custom Algorithm"),
                        selectedIcon: Icon(
                          Icons.abc,
                          color: AppStyle.appColor.withGreen(100),
                        )),
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.account_box,
                        ),
                        label: const Text("Account"),
                        selectedIcon: Icon(
                          Icons.account_box,
                          color: AppStyle.appColor.withGreen(100),
                        )),
                  ],
                  selectedIndex: ref.watch(pageNavigator),
                  extended: notifier.isExpanded,
                  minWidth: minWidth,
                  minExtendedWidth: maxWidth,
                ),
              ),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: PageNavigatorNotifier.controller,
                children: const [Workboard(), FlowScreen(), AccountScreen()],
              ))
            ],
          ),
          Positioned(
              left: notifier.currentWidth - 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeft,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final b = notifier.changeSidemenuWidth(details);
                    if (isExpanded != b) {
                      setState(() {
                        isExpanded = b;
                      });
                      _toggleSidemenu();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 20,
                    height: MediaQuery.of(context).size.height,
                    // child: const SizedBox.expand(),
                  ),
                ),
              )),
          const Positioned(
            right: 20,
            bottom: 20,
            child: JobsBox(),
          ),
        ],
      ),
    );
  }
}
