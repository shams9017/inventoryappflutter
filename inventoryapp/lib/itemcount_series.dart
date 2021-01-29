import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ItemCountSeries
{
  final String item;
  final int count;
  final charts.Color barColor;

  ItemCountSeries(
  {@required this.item, @required this.count,
  @required this.barColor}
      );
}