import 'package:dio/dio.dart';

import '../../storage/storage.dart';

class DioInterceptors extends Interceptor {
  // Dio dio = Dio(BaseOptions(baseUrl: "base-api-url"));

  // Future<(bool, String?)> checkTokenPresent() async {
  //   String? token = await Store.getToken();
  //   print("TOKENi $token");
  //   if (token != null && token.isNotEmpty) {
  //     // check if token is expire
  //     checkToken();
  //     token = await Store.getToken();
  //   }
  //   return (token != null && token.isNotEmpty, token);
  // }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final (isTokenPresent, token) = await checkTokenPresent();
    String? token = await Store.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    // options.headers['Access-Control-Allow-Origin'] = '*';
    // options.headers['Access-Control-Allow-Credentials'] = true;
    // options.headers['Access-Control-Allow-Methods'] = 'GET,HEAD,OPTIONS,POST,PUT';
    // options.headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers';
    //

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //   EasyLoading.dismiss();
    // logger(response.data.toString());
    // logger(response.statusCode.toString());
    // logger("Interceptor response");
    // logger("Interceptor : ${response.data}");
    // if(response.statusCode == 403){
    //   Storage.clear();
    // }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // EasyLoading.showToast("Unable to connect");
    //logger("ERROR: ${err.error}");
    super.onError(err, handler);
  }
}
