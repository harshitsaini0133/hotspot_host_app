import 'package:dio/dio.dart';
import 'package:intern_assignment/core/api_constants.dart';

class ApiClient {
  final Dio dio;

  ApiClient._internal(this.dio);

  factory ApiClient() {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl))
      ..interceptors.add(LogInterceptor(responseBody: false));
    return ApiClient._internal(dio);
  }
}
