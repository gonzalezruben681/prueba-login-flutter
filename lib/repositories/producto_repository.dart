import 'dart:convert';
import 'package:login_flutter/models/models.dart';
//import 'package:login_flutter/service/ApiService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductoRepository {
  final _baseAPI = 'flutter-varios-c8193-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  final storage = new FlutterSecureStorage();

  /*static APIService<List<Product>> getProductos() {
    return APIService(
        url: Uri.https(_baseAPI, 'productos.json', {'auth': hasToken()}),
        parse: (response) {
          final Map<String, dynamic> productsMap = json.decode(response.body);
          productsMap.forEach((key, value) {
            final tempProduct = Product.fromMap(value);
            tempProduct.id = key;
            products.add(tempProduct);
          });

          return products;
        }); */

  Future<List<Product>> getProductos() async {
    final url = Uri.https(_baseAPI, 'productos.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    return products;
  }
}
