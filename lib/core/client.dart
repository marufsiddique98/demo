import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class ApiService {
  final String formUrl = 'wempro/flutter-dev/coding-test-2025/';
  DioClient dioClient = DioClient();
}

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: Duration(seconds: 10),
            receiveTimeout: Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'},
          ),
        );

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw Exception('Failed to post data: $e');
    }
  }
}
