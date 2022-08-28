import 'package:dio/dio.dart';

// https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
// my apikey : 97a2f0178be846b897d27b8f38d8571c
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) {
    return dio.get(url, queryParameters: query);
  }
}
