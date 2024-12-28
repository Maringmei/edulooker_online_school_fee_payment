import 'package:dio/dio.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import '../../storage/storage.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Fetch the base URL dynamically before making the request
    String? baseUrl = await Store.getBaseUrl();
    if (baseUrl != null) {
      options.baseUrl = Endpoint.baseUrl; // Set the baseUrl in the request options
     // options.baseUrl = baseUrl; // Set the baseUrl in the request options
    } else {
      // Handle case where baseUrl is not found, could throw an error or use a fallback URL
      options.baseUrl = 'https://defaultbaseurl.com'; // Example fallback
    }

    // Add token to headers if available
    String? token = await Store.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Set common headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}


// import 'package:dio/dio.dart';
//
// import '../../storage/storage.dart';
//
// class DioInterceptors extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//
//     String? token = await Store.getToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     options.headers['Content-Type'] = 'application/json';
//     options.headers['Accept'] = 'application/json';
//
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//
//
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     super.onError(err, handler);
//   }
// }
