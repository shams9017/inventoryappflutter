import 'package:flutter/material.dart';
import 'package:inventoryapp/itemcount_chart.dart';
import 'apiservice.dart';
import 'itemcount_series.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventoryapp/productlist.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'apiservice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> _productList = <Product>[];
  List<ItemCountSeries> data = [];
  List<int> low_item_count = [];
  List<String> item_names = [];
  String low_item_name;
  int total_count = 0;
  int total_value = 0;


  @override
  void initState() {
    super.initState();
    //getProducts();
    APIService.getProducts().then((products) {
      setState(() {
        _productList = products;
        print(_productList.length);
        for (int j = 0; j < _productList.length; j++) {

          int current_item_count = _productList[j].count;
          int current_item_unitprice = _productList[j].unitPrice;
          int current_item_value = current_item_count * current_item_unitprice;
          total_count = total_count + current_item_count;
          total_value = total_value + current_item_value;
          low_item_count.add(_productList[j].count);

          data.add(ItemCountSeries(
              item: _productList[j].name,
              count: _productList[j].count,
              barColor: charts.ColorUtil.fromDartColor(Colors.blue)));
          if (low_item_count[j] < 4) {
            low_item_name = _productList[j].name;
            showNotification(context);

          }
        }


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      width: 500,
                      padding: EdgeInsets.all(8),
                      child: ItemCountChart(data: data)),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.orange[400],
                    child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: 300,
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(total_count.toString(),
                                  style: TextStyle(
                                      fontSize: 37.0, color: Colors.white)),
                              Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text("Total Items",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)))
                            ],
                          ),
                        ))),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.green[400],
                    child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: 300,
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\$" + total_value.toString(),
                                  style: TextStyle(
                                      fontSize: 37.0, color: Colors.white)),
                              Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text("Total Value",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)))
                            ],
                          ),
                        ))),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[400],
                    child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList()));
                        },
                        child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Container(
                              width: 300,
                              height: 25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("See Products",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )))),
              ],
            ),
          )),
    );
  }

  // method to show notificaiton
  void showNotification(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Low Item Notification"),
            content:
            Text("Item named " + low_item_name + " is low in stock."),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]));
  }
}
