import 'package:edulooker_online_school_fee_payment/src/app/app.dart';
import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';
import 'package:edulooker_online_school_fee_payment/src/core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  // set default url
  Store.setBaseUrl(Endpoint.baseUrl);
  setUrlStrategy(PathUrlStrategy());
  runApp(const App());
}
