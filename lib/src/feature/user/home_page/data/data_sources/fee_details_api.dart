import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';

import '../../../../../core/services/dio/dio_interceptor.dart';
import '../../../../../core/shared/models/shared_model.dart';
import '../../../../../core/storage/storage.dart';
import '../models/fee_details_model.dart';

class FeeDetailsAPI {
  late final Dio _dio;

  FeeDetailsAPI() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptors());
  }

  final String _url = Endpoint.feeDetails;

  /// student profile
  Future<FeeDetailsModel> getFeeDetails({required String id}) async {

    try {
      final response = await _dio.get(_url + id);
      print("Response data: " + response.data.runtimeType.toString());

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return FeeDetailsModel.fromJson(responseData);
        } else {
          return FeeDetailsModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return FeeDetailsModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return FeeDetailsModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return FeeDetailsModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return FeeDetailsModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return FeeDetailsModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return FeeDetailsModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return FeeDetailsModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
