import 'package:flutter_getx/productmodule/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<List<ProductModel>> fetchProducts() async {
    var response = await client.get(Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=marienatie"));

    if (response.statusCode == 200) {
      var data = response.body;
      return productFromJson(data);
    } else {
      // ignore: null_check_always_fails
      return null!;
    }
  }
}
