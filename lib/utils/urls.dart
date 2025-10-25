import 'package:flutter/material.dart';

class Urls {
  static String baseUrl = 'http://35.73.30.144:2008/api/v1';
  static String productUrl = '$baseUrl/ReadProduct';
  static String deleteProductUrl(String id) => '$baseUrl/DeleteProduct/$id';
  static String updateProductUrl(String id) => '$baseUrl/UpdateProduct/$id';
  static String createProductUrl = '$baseUrl/CreateProduct';
}
