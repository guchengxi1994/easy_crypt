import 'package:flutter_flow_chart/flutter_flow_chart.dart';

extension FlowElementExtension on FlowElement {
  FlowElement? findPrevious(List<FlowElement> elements) {
    for (final i in elements) {
      if (i.next.map((e) => e.destElementId).contains(id)) {
        return i;
      }
    }

    return null;
  }
}
