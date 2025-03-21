import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';

import '../../../../../core/services/dio/dio_interceptor.dart';
import '../../../../../core/shared/models/shared_model.dart';
import '../models/verify_otp_model.dart';

class LoginAPI {
  late final Dio _dio;

  LoginAPI() {
    _dio = Dio();
    _dio.interceptors
        .add(DioInterceptors()); // Adding the interceptor to handle baseUrl
  }

  final String _sendOtp = Endpoint.sendOtp;
  final String _verifyOtp = Endpoint.verifyOtp;

  // final String _verifyOtp = EndpointUrl.verifyOtp;

  Map<String, dynamic>? _body;

  /// send OTP to device
  Future<SharedModel> sendOtp({
    required String mobileNumber,
  }) async {
    try {
      _body = {
        "mobile_no": int.parse(mobileNumber),
      };

      final response = await _dio.post(_sendOtp, data: _body);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return SharedModel.fromJson(responseData);
        } else {
          return SharedModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return SharedModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return SharedModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return SharedModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return SharedModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return SharedModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return SharedModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return SharedModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  /// verify otp to device
  Future<VerifyOtpModel> verifyOTP(
      {required String mobileNumber, required String otp}) async {
    try {
      _body = {
        "mobile_no": int.parse(mobileNumber),
        "otp": otp,
      };

      final response = await _dio.post(_verifyOtp, data: _body);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return VerifyOtpModel.fromJson(responseData);
        } else {
          return VerifyOtpModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return VerifyOtpModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return VerifyOtpModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return VerifyOtpModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return VerifyOtpModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return VerifyOtpModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return VerifyOtpModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return VerifyOtpModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
