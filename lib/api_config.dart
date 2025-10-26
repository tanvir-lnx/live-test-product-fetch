import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ApiConfig {
  static const String readProductUrl =
      'http://35.73.30.144:2008/api/v1/ReadProduct';

  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse(readProductUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];

      List<ProductModel> products = dataList
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return products;
    } else {
      throw ('Something went wrong!');
    }
  }
}