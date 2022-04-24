import 'package:flutter/material.dart';
import 'package:providerexample/dio.dart';
import 'package:providerexample/dio_helper/dio_helper.dart';
import 'package:providerexample/models/product_model.dart';

enum dataStatus { loading, done, error }

class storeController extends ChangeNotifier {
  List allProducts = [];
  dataStatus status = dataStatus.loading;

  getProducts() async {
    allProducts = [];
    status = dataStatus.loading;
    notifyListeners();
    final response = await MyDioClass().getData('products').then((value) {
      if (value.statusCode == 200) {
        allProducts = value.data.map((e) {
          return ProductsModel.fromJson(e);
        }).toList();
        status = dataStatus.done;
        notifyListeners();
      } else {
        status = dataStatus.error;
      }

      print(allProducts);
      //  value.data.forEach((element) {});
    });
    notifyListeners();
  }
}
