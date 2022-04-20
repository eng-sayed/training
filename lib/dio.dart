import 'package:dio/dio.dart';

class MyDio {
  static late Dio dio;

  void init() {
    dio = Dio(BaseOptions(baseUrl: "https://newsapi.org/v2/"));
  }

  Future<Response> getData() async {
    final response = await dio.get("top-headlines", queryParameters: {
      "country": "eg",
      "apikey": "0e3e483ab8ba44baac78858982cb4858"
    });
    return response;
  }
}
