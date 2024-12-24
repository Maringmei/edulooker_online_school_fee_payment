import 'dart:html' as html;

import 'package:edulooker_online_school_fee_payment/src/core/services/dio/endpoint_urls.dart';

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';

Future<void> downloadFile(String receiptNo, {String? fileName, required String bearerToken}) async {
  final dio = Dio();
  try {
    final response = await dio.get(
      '${Endpoint.baseUrl}${Endpoint.downloadReceipt}$receiptNo',
      options: Options(
        headers: {'Authorization': 'Bearer $bearerToken'},
        responseType: ResponseType.bytes, // Download as bytes
      ),
    );

    final blob = html.Blob([response.data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank' // Opens in a new tab
      ..download = "Fee_Receipt_$receiptNo.pdf" ?? 'downloaded_file'; // File name
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove(); // Clean up
    html.Url.revokeObjectUrl(url); // Free memory
  } catch (e) {
    print('Error downloading file: $e');
  }
}


// void downloadFile(String receiptNo, {String? fileName}) {
//   final anchor = html.AnchorElement(href: Endpoint.baseUrl + Endpoint.downloadReceipt + receiptNo)
//     ..target = 'blank' // Opens in a new tab, optional
//     ..download = fileName ?? ''; // File name, optional
//   html.document.body?.append(anchor);
//   anchor.click();
//   anchor.remove(); // Clean up
// }