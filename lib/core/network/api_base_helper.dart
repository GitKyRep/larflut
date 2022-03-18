import 'package:dio/dio.dart';

import 'logging.dart';

class ApiBaseHelper {
  static const String endPointDemo = 'http://localhost:8000/api/v1/';
  static BaseOptions opts = BaseOptions(
    baseUrl: endPointDemo,
    contentType: Headers.formUrlEncodedContentType,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio..interceptors.add(Logging());
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    // Get your JWT token
    const token = '';
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response?> getHTTP(String url) async {
    try {
      Response response = await baseAPI.get(url);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    try {
      print("params $data");
      Response response = await dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }

  Future<Response?> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError {
      // Handle error
    }
  }
}
