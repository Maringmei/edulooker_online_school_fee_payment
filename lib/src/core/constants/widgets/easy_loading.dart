import 'package:flutter_easyloading/flutter_easyloading.dart';

showStatus({required String msg}){
  EasyLoading.show(status: msg, maskType: EasyLoadingMaskType.black);
}
showToast({required String msg}){
  EasyLoading.showToast(msg);
}
showDismiss(){
  EasyLoading.dismiss();
}