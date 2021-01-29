import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.name,
    this.count,
    this.unitPrice,
    this.category,
  });

  int id;
  String name;
  int count;
  double unitPrice;
  String category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    count: json["count"],
    unitPrice: json["unitPrice"].toDouble(),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "count": count,
    "unitPrice": unitPrice,
    "category": category,
  };
}
