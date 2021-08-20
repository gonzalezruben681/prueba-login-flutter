import 'dart:convert';
import 'package:login_flutter/constantes.dart';
import 'package:login_flutter/producto/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductoRepository {
  //final _baseAPI = 'flutter-varios-c8193-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  final storage = new FlutterSecureStorage();

  Future<List<Product>> getProductos() async {
    final url = Uri.https(baseApi, 'productos.json',
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
