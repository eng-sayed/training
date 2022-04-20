import 'package:flutter/material.dart';
import 'package:providerexample/dio.dart';
import 'package:providerexample/dio_helper/dio_helper.dart';
import 'package:providerexample/models/product_model.dart';

class storeController extends ChangeNotifier {
  List allProducts = [];

  getProducts() async {
    allProducts = [];
    notifyListeners();
    final response = await MyDioClass().getData('products').then((value) {
      allProducts = value.data.map((e) {
        return ProductsModel.fromJson(e);
      }).toList();
      print(allProducts);
      //  value.data.forEach((element) {});
    });
    notifyListeners();
  }
}
