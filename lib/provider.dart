import 'package:flutter/cupertino.dart';
import 'package:providerexample/dio.dart';
import 'package:providerexample/newsmodel.dart';

class AppProvider extends ChangeNotifier {
  int counter = 0;

  void increament() {
    counter++;
    notifyListeners();
  }

  NewsModel? allNews;
  void getAllNews() async {
    final newsdata = await MyDio().getData();
    allNews = NewsModel.fromJson(newsdata.data);

    notifyListeners();
  }
}
