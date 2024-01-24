import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_crypt/account/account_screen.dart';
import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/src/rust/api/simple.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/customize_flow/flow_screen.dart';
import 'package:easy_crypt/gen/strings.g.dart';
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
import 'notifiers/setting_notifier.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

const double minWidth = 70;
const double maxWidth = 200;

class _LayoutState extends ConsumerState<Layout> with TickerProviderStateMixin {
  final stream = nativeMessageStream();

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

    future = Future(() => initI18n());
  }

  // ignore: prefer_typing_uninitialized_variables
  var future;

  initI18n() {
    LocaleSettings.setLocaleRaw(ref.read(settingsNotifier).currentLocale);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final __ = ref.watch(settingsNotifier);
    final _ = ref.watch(accountProvider);
    return FutureBuilder(
        future: future,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.done) {
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
                      DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        customButton: const Icon(
                          Icons.language,
                          size: 20,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // print(value);
                        },
                        dropdownStyleData: DropdownStyleData(
                          width: 250,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          offset: const Offset(0, 8),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(left: 16, right: 16),
                        ),
                        items: ref
                            .read(settingsNotifier)
                            .supportLocales
                            .map((e) => DropdownMenuItem(
                                  value: 1,
                                  onTap: () async {
                                    ref
                                        .read(settingsNotifier.notifier)
                                        .changeCurrentLocale(e);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.language_sharp,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(e)
                                    ],
                                  ),
                                ))
                            .toList(),
                      ))
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
                                label: Text(t.layout.encryption),
                                selectedIcon: Icon(
                                  Icons.security,
                                  color: AppStyle.appColor.withGreen(100),
                                )),
                            NavigationRailDestination(
                                icon: const Icon(
                                  Icons.abc,
                                ),
                                label: Text(t.layout.custom),
                                selectedIcon: Icon(
                                  Icons.abc,
                                  color: AppStyle.appColor.withGreen(100),
                                )),
                            NavigationRailDestination(
                                icon: const Icon(
                                  Icons.account_box,
                                ),
                                label: Text(t.layout.account),
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
                        children: const [
                          Workboard(),
                          FlowScreen(),
                          AccountScreen()
                        ],
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
