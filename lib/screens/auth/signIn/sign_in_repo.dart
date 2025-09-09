import 'package:bookevent/env_config.dart';
import 'package:dio/dio.dart';

class SignInRepo {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: EnvConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api-token-auth/',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "data": response.data,
          "message": "Login successful",
        };
      } else {
        return {
          "success": false,
          "data": null,
          "message": "Unexpected error: ${response.statusCode}",
        };
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";
      if (e.response != null) {
        errorMessage =
            e.response?.data?['detail'] ?? "Error: ${e.response?.statusCode}";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Connection timeout. Please try again.";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Server not responding. Please try again.";
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = "No internet connection.";
      }
      return {
        "success": false,
        "data": null,
        "message": errorMessage,
      };
    } catch (e) {
      // Fallback error
      return {
        "success": false,
        "data": null,
        "message": "Unexpected error: $e",
      };
    }
  }
}
