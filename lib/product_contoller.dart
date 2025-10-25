import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m16assignment/model/product_model.dart';
import 'package:m16assignment/utils/urls.dart';

class ProductController {
  List<Data> products = [];

  Future fetchProduct() async {
    final response = await http.get(Uri.parse(Urls.productUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<bool> fetchDelete(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProductUrl(id)));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createProduct(
    String name,
    String img,
    int qty,
    int unitPrice,
  ) async {
    final totalPrice = qty * unitPrice;
    final response = await http.post(
      Uri.parse(Urls.createProductUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );
    if (response.statusCode == 200) {
      await fetchProduct();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(
    String id,
    String name,
    String img,
    int qty,
    int unitPrice,
  ) async {
    final totalPrice = qty * unitPrice;
    final response = await http.post(
      Uri.parse(Urls.updateProductUrl(id)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
