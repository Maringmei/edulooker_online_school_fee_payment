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
      options.baseUrl = baseUrl; // Set the baseUrl in the request options
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
    // Check for 401 status and clear the store if the status code is 401
    if (response.statusCode == 401) {
      Store.clear();  // Clear the store on 401 Unauthorized response
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}


// class DioInterceptors extends Interceptor {
//   final BuildContext? context;
//   DioInterceptors({this.context}); // Constructor to accept BuildContext
//
//   Dio dio = Dio(); // Configure Dio instance
//
//   Future<(bool, String?)> checkTokenPresent() async {
//     String? token = await Store.getToken();
//     if (token != null && token.isNotEmpty) {
//       final isExpired = await checkToken(); // Check if token is expired
//       if (isExpired) {
//         final refreshSuccess =
//         await refreshToken(); // Attempt to refresh the token
//         if (!refreshSuccess) {
//           // If refresh fails, handle logout
//           await handleLogout();
//           return (false, null);
//         }
//         token = await Store.getToken(); // Get the new token after refresh
//       }
//     }
//     return (token != null && token.isNotEmpty, token);
//   }
//
//   Future<bool> refreshToken() async {
//     String? refreshToken = await Store.getTokenRefresh();
//     if (refreshToken != null && refreshToken.isNotEmpty) {
//       try {
//         final response = await dio.post(
//           '${ApiUrl.baseUrl}/api/auth/refresh-token', // Replace with your API endpoint
//           data: {'refreshToken': refreshToken},
//         );
//         if (response.statusCode == 200) {
//           final newAccessToken = response.data['data']['accessToken'];
//           final newRefreshToken = response.data['data']['refreshToken'];
//           await Store.setToken(newAccessToken);
//           await Store.setTokenRefresh(newRefreshToken);
//           return true;
//         } else {
//           // Handle token refresh failure
//           await handleLogout();
//           return false;
//         }
//       } catch (e) {
//         // Handle refresh token error
//         print("Error refreshing token: $e");
//         await handleLogout();
//         return false;
//       }
//     } else {
//       // If no refresh token is available, treat as failure
//       await handleLogout();
//       return false;
//     }
//   }
//
//   Future<void> handleLogout() async {
//     await Store.clear(); // Implement this to clear stored tokens
//     globalWidget.show();
//   }
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final (isTokenPresent, token) = await checkTokenPresent();
//     if (isTokenPresent) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//
//     options.headers['Content-Type'] = 'application/json';
//     options.headers['Accept'] = 'application/json';
//
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     EasyLoading.dismiss();
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     String? url = err.requestOptions.uri.toString();
//
//     // Log or handle the URL as needed
//     print("Request URL: $url");
//     if (err.response?.statusCode == 401) {
//       EasyLoading.showToast("Session expire");
//       final refreshSuccess = await refreshToken();
//       if (refreshSuccess) {
//         final (isTokenPresent, token) = await checkTokenPresent();
//         if (isTokenPresent) {
//           // Retry the failed request with the new token
//           final opts = err.requestOptions;
//           opts.headers['Authorization'] = 'Bearer $token';
//           try {
//             final retryResponse = await dio.request(
//               opts.path,
//               options: Options(
//                 method: opts.method,
//                 headers: opts.headers,
//               ),
//               data: opts.data,
//               queryParameters: opts.queryParameters,
//             );
//             return handler.resolve(retryResponse);
//           } catch (e) {
//             return handler.reject(DioException(requestOptions: opts, error: e));
//           }
//         }
//       }
//       // If refresh failed, handle logout
//       await handleLogout();
//     } else {
//       // EasyLoading.showToast("Unable to connect");
//     }
//
//     EasyLoading.dismiss();
//     super.onError(err, handler);
//   }
// }