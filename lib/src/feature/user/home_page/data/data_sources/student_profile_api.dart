import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';

import '../../../../../core/services/dio/dio_interceptor.dart';

import '../../../../../core/storage/storage.dart';
import '../models/sibling_list_model.dart';

class StudentProfileAPI {
  late final Dio _dio;

  StudentProfileAPI() {
    _dio = Dio();
    _dio.interceptors
        .add(DioInterceptors()); // Adding the interceptor to handle baseUrl
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

  final String _url = Endpoint.siblings;

  /// Get student profile
  Future<SiblingModel> getSiblings() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {

          return SiblingModel.fromJson(responseData);
        } else {
          return SiblingModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error occurred.",
          );
        }
      } else {
        return SiblingModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      // Handle Dio exceptions
      if (e.response != null) {
        return SiblingModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        return SiblingModel(
          success: false,
          data: null,
          message: "Connection timeout. Please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return SiblingModel(
          success: false,
          data: null,
          message: "Receive timeout. Please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        return SiblingModel(
          success: false,
          data: null,
          message:
              "No internet connection. Please check your connection and try again.",
        );
      } else {
        return SiblingModel(
          success: false,
          data: null,
          message: "Unable to connect to the server.",
        );
      }
    } catch (e) {
      // Generic error handling
      return SiblingModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
