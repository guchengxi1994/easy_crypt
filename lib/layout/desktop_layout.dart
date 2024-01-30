import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_crypt/common/toast_utils.dart';
import 'package:easy_crypt/datasource/datasource_screen.dart';
import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/file_system/components/board.dart';
import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/fs_preview.dart';
import 'package:easy_crypt/file_system/notifiers/cached_datasource_notifier.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart';
import 'package:easy_crypt/src/rust/api/simple.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/customize_flow/flow_screen.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/layout/components/jobs_box.dart';
import 'package:easy_crypt/layout/models/job_state.dart';
import 'package:easy_crypt/layout/notifiers/job_notifier.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/records/notifiers/records_notifier.dart';
import 'package:easy_crypt/records/process_records_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'notifiers/expand_collapse_notifier.dart';
import 'notifiers/navigator_notifier.dart';
import 'notifiers/setting_notifier.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

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
        ref.read(recordsProvider.notifier).changeProgress(
            j["unique_id"], j["encrypt_size"] / j["total_size"]);
      } else if (j["type"] == 3) {
      } else if (j['type'] == 4) {
        UploadJob uploadJob = UploadJob.fromJson(j);
        ref.read(jobProvider.notifier).update(uploadJob);
      } else if (j['type'] == 1) {
        ref.read(recordsProvider.notifier).changeProgress(
            j["unique_id"], j["total_size"] / j["encrypt_size"]);
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
    final _ = ref.watch(datasourceProvider);
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
                          key: DevUtils.navigationKey,
                          onDestinationSelected: (value) {
                            ref.read(pageNavigator.notifier).changeState(value);
                          },
                          backgroundColor: Colors.transparent,
                          destinations: [
                            NavigationRailDestination(
                                icon: const Icon(
                                  Icons.transform,
                                ),
                                label: Text(t.layout.workboard),
                                selectedIcon: Icon(
                                  Icons.transform,
                                  color: AppStyle.appColor.withGreen(100),
                                )),
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
                                  Icons.dataset,
                                ),
                                label: Text(t.layout.account),
                                selectedIcon: Icon(
                                  Icons.dataset,
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
                        children: [
                          Board(
                            left: const FsPreview(
                              previewType: PreviewType.Left,
                            ),
                            right: DragTarget<Entry>(onAccept: (data) async {
                              // print(data.path);
                              if (ref
                                          .read(cachedProvider.notifier)
                                          .findLeft() ==
                                      null ||
                                  ref
                                          .read(cachedProvider.notifier)
                                          .findRight() ==
                                      null) {
                                ToastUtils.error(context,
                                    title: "invalid datasource");
                                return;
                              }

                              if (data.type == EntryType.file) {
                                final name = basename(data.path);
                                await transferBetweenTwoDatasource(
                                        p: data.path,
                                        savePath: "easy_encrypt_upload/$name",
                                        autoEncrypt: true)
                                    .then((value) {
                                  if (value != "error") {
                                    ref
                                        .read(recordsProvider.notifier)
                                        .newTwoDatasourceRecords(
                                            data.path,
                                            "easy_encrypt_upload/$name",
                                            ref
                                                .read(cachedProvider.notifier)
                                                .findLeft()!,
                                            ref
                                                .read(cachedProvider.notifier)
                                                .findRight()!,
                                            key: value);
                                  } else {
                                    ToastUtils.error(context,
                                        title: "transfer error");
                                  }
                                });
                              }
                            }, builder: (c, _, __) {
                              return const FsPreview(
                                previewType: PreviewType.Right,
                              );
                            }),
                          ),
                          const ProcessRecordsScreen(),
                          const FlowScreen(),
                          const DatasourceScreen(),
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
