import 'package:dio/dio.dart';

class DioAdapter {
  late Dio _dio;
  DioAdapter() {
    _dio = Dio();
  }

  Future<dynamic> getRequest() async {
    Response<dynamic> response = await _dio.get('https://official-joke-api.appspot.com/random_ten');
    return response.data;
  }

}