import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';

import '../../../../../core/services/dio/dio_interceptor.dart';

import '../../../../../core/storage/storage.dart';

class StudentProfileAPI {
  late final Dio _dio;

  StudentProfileAPI() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptors()); // Adding the interceptor to handle baseUrl
  }

  // Future<void> _initializeBaseUrl() async {
  //   String? baseUrl = await Store.getBaseUrl();
  //   if (baseUrl != null) {
  //     _dio.options.baseUrl = baseUrl;
  //     print("Base URL initialized: $baseUrl");
  //   } else {
  //     throw Exception("Base URL could not be retrieved from storage.");
  //   }
  // }

  final String _url = Endpoint.studentProfile;

  /// Get student profile
  Future<StudentProfileModel> getStudentProfile() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return StudentProfileModel.fromJson(responseData);
        } else {
          return StudentProfileModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error occurred.",
          );
        }
      } else {
        return StudentProfileModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      // Handle Dio exceptions
      if (e.response != null) {
        return StudentProfileModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        return StudentProfileModel(
          success: false,
          data: null,
          message: "Connection timeout. Please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return StudentProfileModel(
          success: false,
          data: null,
          message: "Receive timeout. Please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        return StudentProfileModel(
          success: false,
          data: null,
          message:
          "No internet connection. Please check your connection and try again.",
        );
      } else {
        return StudentProfileModel(
          success: false,
          data: null,
          message: "Unable to connect to the server.",
        );
      }
    } catch (e) {
      // Generic error handling
      return StudentProfileModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
