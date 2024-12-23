import 'dart:html' as html;

import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';

void downloadFile(String receiptNo, {String? fileName}) {
  final anchor = html.AnchorElement(href: Endpoint.baseUrl + Endpoint.downloadReceipt + receiptNo)
    ..target = 'blank' // Opens in a new tab, optional
    ..download = fileName ?? ''; // File name, optional
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove(); // Clean up
}