import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:inventoryapp/itemcount_series.dart';

class ItemCountChart extends StatelessWidget
{
  final List<ItemCountSeries> data;

  ItemCountChart(
  {@required this.data});

  @override
  Widget build(BuildContext context)
  {
    List<charts.Series<ItemCountSeries, String>> series
    = [
      charts.Series(
        id: "Itemcounts",
        data: data,
        domainFn: (ItemCountSeries series, _) =>
        series.item,
        measureFn: (ItemCountSeries series, _) =>
        series.count,
        colorFn: (ItemCountSeries series, _) =>
        series.barColor)


    ];

    return Container(height: 300, padding: EdgeInsets.all(10),
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
          child: Column(
              children: <Widget>[
                Text("Items by count", style: Theme.of(context).textTheme.body2,
                ),
                Expanded(child: charts.BarChart(series, animate: true,
                  domainAxis: new charts.OrdinalAxisSpec(
                    renderSpec: new charts.SmallTickRendererSpec(
                        minimumPaddingBetweenLabelsPx: 5,
                        // Tick and Label styling here.
                        labelStyle: new charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: charts.MaterialPalette.black),),
                )
                ))]
          )
      )

    ));
  }

}