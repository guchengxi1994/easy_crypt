import 'package:easy_crypt/customize_flow/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';
import 'package:star_menu/star_menu.dart';
import 'components/preview.dart';

class FlowScreen extends StatefulWidget {
  const FlowScreen({super.key});

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> {
  Dashboard dashboard = Dashboard();
  final GlobalKey<PreviewState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (dashboard.elements.isEmpty) {
        dashboard.addElement(FlowElement(
            position: const Offset(100, 100),
            size: const Size(100, 50),
            text: '开始',
            kind: ElementKind.oval,
            handlers: []));

        _onNodeChanged();
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),

        // child: Container(color: Colors.amber),

        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: FlowChart(
                dashboard: dashboard,
                onDashboardTapped: ((context, position) {
                  debugPrint('Dashboard tapped $position');
                  _displayDashboardMenu(context, position);
                }),
                onDashboardSecondaryTapped: (context, position) {
                  debugPrint('Dashboard right clicked $position');
                  _displayDashboardMenu(context, position);
                },
                onElementPressed: (context, position, element) {
                  debugPrint('Element with "${element.text}" text pressed');
                  _displayElementMenu(context, position, element);
                },
              ),
            ),
            Positioned(
                right: 20,
                child: Preview(
                  key: globalKey,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => dashboard.recenter(),
          child: const Icon(Icons.center_focus_strong)),
    );
  }

  /// Display a drop down menu when tapping on an element
  _displayElementMenu(
    BuildContext context,
    Offset position,
    FlowElement element,
  ) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          onHoverScale: 1.1,
          centerOffset: position - const Offset(50, 50),
          backgroundParams: const BackgroundParams(
            backgroundColor: Colors.transparent,
          ),
          boundaryBackground: BoundaryBackground(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              boxShadow: kElevationToShadow[6],
            ),
          ),
        ),
        onItemTapped: (index, controller) {
          if (!(index == 5 || index == 2)) {
            controller.closeMenu!();
          }
        },
        items: [
          Text(
            element.text,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          InkWell(
            onTap: () {
              final prev = element.findPrevious(dashboard.elements);
              assert(prev != null, "prev cannot be null");

              /// FIXME sometimes find no elements
              final next = dashboard.elements
                  .where((e) => e.id == element.next.first.destElementId)
                  .firstOrNull;
              assert(next != null, "next cannot be null");

              dashboard.removeElement(element);

              if (next != null && prev != null) {
                dashboard.addNextById(prev, next.id, const ArrowParams());
                _onNodeChanged();
              }
            },
            child: const Text('Delete'),
          ),
        ],
        parentContext: context,
      ),
    );
  }

  /// Display a linear menu for the dashboard
  /// with menu entries built with [menuEntries]
  _displayDashboardMenu(BuildContext context, Offset position) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          // calculate the offset from the dashboard center
          centerOffset: position -
              Offset(
                dashboard.dashboardSize.width / 2,
                dashboard.dashboardSize.height / 2,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        parentContext: context,
        items: [
          ActionChip(
              label: const Text('添加XOR算子'),
              onPressed: () {
                final xor = FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: 'XOR',
                    kind: ElementKind.rectangle,
                    handlers: []);
                dashboard.addElement(xor, notify: false);
                // print(xor.id);
                dashboard.addNextById(
                    dashboard.elements[dashboard.elements.length - 2],
                    xor.id,
                    const ArrowParams(),
                    notify: true);

                _onNodeChanged();
              }),
          ActionChip(
              label: const Text('添加NOT算子'),
              onPressed: () {
                final not = FlowElement(
                    position: position - const Offset(40, 40),
                    size: const Size(80, 80),
                    text: 'NOT',
                    kind: ElementKind.rectangle,
                    handlers: []);
                dashboard.addElement(not, notify: false);
                // print(xor.id);
                dashboard.addNextById(
                    dashboard.elements[dashboard.elements.length - 2],
                    not.id,
                    const ArrowParams(),
                    notify: true);

                _onNodeChanged();
              }),
          ActionChip(
              label: const Text('添加AES算子'),
              onPressed: () {
                final aes = FlowElement(
                    position: position - const Offset(40, 40),
                    size: const Size(80, 80),
                    text: 'AES',
                    kind: ElementKind.rectangle,
                    handlers: []);
                dashboard.addElement(aes, notify: false);
                // print(xor.id);
                dashboard.addNextById(
                    dashboard.elements[dashboard.elements.length - 2],
                    aes.id,
                    const ArrowParams(),
                    notify: true);

                _onNodeChanged();
              }),
          ActionChip(
              label: const Text('清空'),
              onPressed: () {
                dashboard.removeAllElements();

                setState(() {});
                _onNodeChanged();
              }),
        ],
      ),
    );
  }

  _onNodeChanged() {
    globalKey.currentState!.refreshChildren(dashboard.elements);
  }
}
