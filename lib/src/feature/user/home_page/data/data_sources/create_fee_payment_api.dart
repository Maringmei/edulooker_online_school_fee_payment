import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';

import '../../../../../core/services/dio/dio_interceptor.dart';
import '../../../../../core/shared/models/shared_model.dart';
import '../models/create_fee_model.dart';

class CreateFeePaymentAPI {
  late final Dio _dio;

  CreateFeePaymentAPI() {
    _dio = Dio(BaseOptions(baseUrl: Endpoint.baseUrl));
    _dio.interceptors.add(DioInterceptors());
  }

  final String _url = Endpoint.createFeePayment;
  final String _urlRetry = Endpoint.createRetryFeePayment;

  Map<String, dynamic> _body = {};

  /// create payment
  Future<CreateFeeModel> createFeePayment(
      {required String feeType, required String feeID}) async {
    try {
      _body = {"fee_type": feeType, "fee_id": feeID};
      final response = await _dio.post(_url, data: _body);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return CreateFeeModel.fromJson(responseData);
        } else {
          return CreateFeeModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return CreateFeeModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return CreateFeeModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return CreateFeeModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  /// create retry payment
  Future<CreateFeeModel> createRetryFeePayment(
      {required String feeType, required String feeID}) async {
    try {
      _body = {"fee_type": feeType, "fee_id": feeID};
      final response = await _dio.post(_urlRetry, data: _body);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return CreateFeeModel.fromJson(responseData);
        } else {
          return CreateFeeModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return CreateFeeModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return CreateFeeModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return CreateFeeModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return CreateFeeModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
