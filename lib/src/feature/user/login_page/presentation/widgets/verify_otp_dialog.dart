// import 'dart:async';
// import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:heroicons/heroicons.dart';
//
// import '../../../../../core/constants/colors/color_constants.dart';
// import '../../../../../core/constants/widgets/easy_loading.dart';
// import '../../../../../core/constants/widgets/pinput_widget.dart';
// import '../../../../../core/constants/widgets/text_widgets.dart';
// import '../../data/models/login_data_model.dart';
// import '../../data/repositories/login_repo.dart';
//
// class OtpDialog extends StatefulWidget {
//   final BuildContext context;
//   final LoginDataModel data;
//
//   OtpDialog({super.key, required this.context, required this.data});
//
//   @override
//   State<OtpDialog> createState() => _OtpDialogState();
// }
//
// class _OtpDialogState extends State<OtpDialog> {
//   String? otpPin;
//   LoginRepo apiRepo = LoginRepo();
//
//   final ValueNotifier<int> _secondsNotifier =
//       ValueNotifier<int>(30); // Initial countdown time
//   late Timer _timer;
//   final int _initialCountdown = 30;
//
//   otpVerify(
//       {required BuildContext context,
//       required String regdNumber,
//       required String mobileNumber,
//       required String pin}) async {
//     await apiRepo
//         .verifyOtp(
//       context: context,
//       regdNumber: regdNumber,
//       mobileNumber: mobileNumber,
//       otp: pin,
//     )
//         .then((value) async {
//       if (value) {
//         if (widget.context.mounted) {
//           await Future.delayed(Duration(seconds: 1));
//           Navigator.of(context).pop(true);
//           //ctx.go(RouteList.home);
//         }
//       }
//     });
//   }
//
//   _resendOTP() async {
//     await apiRepo
//         .sendOtp(
//       context: context,
//       regdNumber: widget.data.registrationNumber,
//       dob: widget.data.dob,
//       mobileNumber: widget.data.mobileNumber,
//     )
//         .then((value) {
//       if (value) {
//         // Restart the timer
//         _startTimer();
//       } else {}
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _secondsNotifier.value = _initialCountdown;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsNotifier.value > 0) {
//         _secondsNotifier.value -= 1;
//       } else {
//         _timer.cancel();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _secondsNotifier.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(19.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }
//
//   Widget contentBox(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Stack(
//       children: <Widget>[
//         Container(
//           width: 500,
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(0, 10),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: Container(
//             color: KColor.white,
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const TextWidget(
//                         text: "Enter OTP",
//                         tColor: KColor.black,
//                         fontWeight: 600,
//                         fontSize: 26),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: HeroIcon(
//                           HeroIcons.xCircle,
//                           color: KColor.red,
//                         ))
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 const SizedBox(height: 22),
//                 PinputWidget(onCompleted: (value) {
//                   otpPin = value;
//                   if (otpPin != null && otpPin!.length == 6) {
//                     //otpVerify(context: context, pin: otpPin!);
//                   } else {
//                     showToast(msg: "Not valid otp.");
//                   }
//                 }),
//                 const Gap(10),
//                 Row(
//                   children: [
//                     ValueListenableBuilder<int>(
//                       valueListenable: _secondsNotifier,
//                       builder: (context, seconds, child) {
//                         return InkWell(
//                           onTap: seconds == 0
//                               ? () {
//                                   _resendOTP();
//                                 }
//                               : null,
//                           child: Text(
//                             seconds == 0 ? "Resend OTP now" : "Resend : ",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: seconds == 0
//                                     ? KColor.appColor
//                                     : KColor.black),
//                           ),
//                         );
//                       },
//                     ),
//                     ValueListenableBuilder<int>(
//                       valueListenable: _secondsNotifier,
//                       builder: (context, seconds, child) {
//                         return Text(
//                           seconds > 0 ? "OTP in $seconds seconds" : "",
//                           style: const TextStyle(
//                               fontSize: 14, color: KColor.black),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 const Gap(10),
//                 ButtonWidget(
//                     text: "Verify",
//                     fullWidth: true,
//                     onTap: () {
//                       if (otpPin != null && otpPin!.length == 6) {
//                         otpVerify(
//                             context: context,
//                             pin: otpPin!,
//                             regdNumber: widget.data.registrationNumber,
//                             mobileNumber: widget.data.mobileNumber);
//                       } else {
//                         showToast(msg: "Not valid otp.");
//                       }
//                     })
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
