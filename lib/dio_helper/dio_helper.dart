import 'package:dio/dio.dart';

class MyDioClass {
  static late Dio dio;

  void init() {
    dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/"));
  }

  Future<Response> getData(String path) async {
    final response = await dio.get(
      path,
    );
    return response;
  }

  Future<Response> postData(String path, dataModel) async {
    final response = await dio.post(path, data: dataModel);
    return response;
  }
}
