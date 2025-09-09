import 'package:bookevent/env_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventRepo {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: EnvConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> createEvent(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await _dio.post(
        '/api/events/',
        data: data,
        options: Options(
          headers: {
            "Authorization": "Token ${prefs.getString('access_token')}",
          },
        ),
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
