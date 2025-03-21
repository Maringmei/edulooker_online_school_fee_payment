import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import '../../../../../core/services/dio/dio_interceptor_siblings.dart';
import '../models/fee_total_multiple_model.dart';

class FeeTotalReportAPI {
  late final Dio _dio;

  FeeTotalReportAPI() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptorsSiblings());
  }

  final String _url = Endpoint.totalFee;

  /// fee details
  Future<FeeTotalMultipleModel> getTotalFeeReport(List<String> ids) async {
    try {
      List<int> intList = ids.map(int.parse).toList();
      final response = await _dio.post(_url, data: {"fee_id": intList});
      print("Response data: " + response.data.runtimeType.toString());

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return FeeTotalMultipleModel.fromJson(responseData);
        } else {
          return FeeTotalMultipleModel(
            success: false,
            data: null,
            message: responseData['message'] ?? "Unexpected error",
          );
        }
      } else {
        return FeeTotalMultipleModel(
          success: false,
          data: null,
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        return FeeTotalMultipleModel.fromJson(e.response!.data);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // Connection timeout
        return FeeTotalMultipleModel(
          success: false,
          data: null,
          message: "Connection timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Receive timeout
        return FeeTotalMultipleModel(
          success: false,
          data: null,
          message: "Receive timeout, please try again later.",
        );
      } else if (e.type == DioExceptionType.unknown) {
        // No internet connection or other network-related issues
        return FeeTotalMultipleModel(
          success: false,
          data: null,
          message:
              "No internet connection, please check your connection and try again.",
        );
      } else {
        // Other errors
        return FeeTotalMultipleModel(
          success: false,
          data: null,
          message: "Not able to connect server",
        );
      }
    } catch (e) {
      // Generic error handling
      return FeeTotalMultipleModel(
        success: false,
        data: null,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
