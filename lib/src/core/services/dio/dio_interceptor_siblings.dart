import 'package:dio/dio.dart';

import '../../storage/storage.dart';

class DioInterceptorsSiblings extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Fetch the base URL dynamically before making the request
    String? baseUrl = await Store.getBaseUrlSiblings();
    // String baseUrl = Endpoint.baseUrl;
    if (baseUrl != null) {
      options.baseUrl = baseUrl; // Set the baseUrl in the request options
    } else {
      // Handle case where baseUrl is not found, could throw an error or use a fallback URL
      options.baseUrl = 'https://defaultbaseurl.com'; // Example fallback
    }

    // Add token to headers if available
    String? token = await Store.getBaseUrlSiblings();
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
    // Check for 401 status and clear the store if the status code is 401
    if (response.statusCode == 401) {
      Store.clear(); // Clear the store on 401 Unauthorized response
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
