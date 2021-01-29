import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apiservice.dart';
import 'product.dart';
import 'dart:convert';


class ProductList extends StatefulWidget {
  //
  ProductList() : super();

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  List<Product> _products;
  bool _loading;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loading = true;
    APIService.getProducts().then((products) {
      setState(() {
        _products = products;
        _loading = false;
        filteredProducts = _products;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Products'),
          actions: <Widget>[
          IconButton(
          icon: Icon(
          Icons.add,
          color: Colors.white,
      ))]
      ),
      body: Column(
        //color: Colors.white,

        children: <Widget>
        [
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Search by name or category',
            ),
            onChanged: (string)
            {
              setState(() {
                filteredProducts = _products.where((prod)=>
                (prod.name.toLowerCase().contains(string.toLowerCase())
                ||prod.category.toLowerCase().contains(string.toLowerCase()))).toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
    itemCount: null == _products ? 0 : filteredProducts.length,
    itemBuilder: (context, index) {
    Product product = _products[index];
    return ListTile(
    title: Text(filteredProducts[index].name),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Quantity: " + filteredProducts[index].count.toString()),
    Text(filteredProducts[index].category.toString())
    ],
    ),

    trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Icon(Icons.edit),
    Icon(Icons.delete)

    ]
    ));
    },
    ),
    ),
          ])



        //bottomNavigationBar: BottomNavigationBar(
        //items: const <BottomNavigationBarItem>[
        //BottomNavigationBarItem(
        //icon: Icon(Icons.home),
    //label: 'Dashboard',
    //),
    //],
    //)
    );}
}