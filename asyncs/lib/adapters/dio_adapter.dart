import 'package:dio/dio.dart';

class DioAdapter {
  late Dio _dio;
  DioAdapter() {
    _dio = Dio();
  }

  Future<dynamic> getRequest(String url) async {
    Response<dynamic> response = await _dio.get(url);
    return response.data;
  }

}