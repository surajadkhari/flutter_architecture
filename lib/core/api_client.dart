import 'package:dio/dio.dart';

import 'package:flutter_architecture/core/api_constant.dart';
import 'package:flutter_architecture/core/exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  Future request(
      {required String path,
      String type = "get",
      Map<String, dynamic>? data}) async {
    Dio dio = Dio(
      BaseOptions(baseUrl: ApiConstant.baseUrl),
    );
    try {
      final response = type == 'get'
          ? await dio.get(path)
          : await dio.post(path, data: data);

      return response.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }
}
