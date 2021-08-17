// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

import 'package:login_flutter/models/models.dart';

class Product {
  Product(
      {required this.disponible,
      required this.titulo,
      this.fotoUrl,
      required this.valor,
      this.id});

  bool disponible;
  String titulo;
  String? fotoUrl;
  double valor;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        disponible: json["disponible"],
        titulo: json["titulo"],
        fotoUrl: json["fotoUrl"],
        valor: json["valor"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "titulo": titulo,
        "fotoUrl": fotoUrl,
        "valor": valor,
      };

  /*Product copy() => Product(
        disponible: this.disponible,
        titulo: this.titulo,
        fotoUrl: this.fotoUrl,
        valor: this.valor,
        id: this.id,
      ); */
}
