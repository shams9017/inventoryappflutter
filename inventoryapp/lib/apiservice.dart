

import 'package:http/http.dart' as http;
import 'package:inventoryapp/product.dart';

class APIService
{
  static const String apiURL = 'https://inventorywebapishams.azurewebsites.net/product';

  static Future<List<Product>> getProducts() async
  {
    try{
      final response = await http.get(apiURL);
      if(200 == response.statusCode)
        {
          final List<Product> products = productFromJson(response.body);
          print(response.body);
          return products;
        }
    }
    catch(e)
    {
      return <Product>[];
    }
  }
}