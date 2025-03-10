import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/pages/home_page.dart';
import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import '../core/constants/colors/color_constants.dart';
import '../feature/user/login_page/presentation/pages/login_page.dart';
import '../route/router_config.dart';
import 'bloc_wrapper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MultiBlocWrapper(
          app: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Edulooker Online School Fee Payment",
            theme: ThemeData(
                fontFamily: "Poppins",
                appBarTheme: const AppBarTheme(
                  backgroundColor: KColor.appColor, // Set background color here
                ),
                scaffoldBackgroundColor: KColor.filledColor,
                visualDensity: VisualDensity.standard),
            routerConfig: router,
            builder: EasyLoading.init(builder: FlashyFlushbarProvider.init()),
          ),
        );
      },
      maximumSize: Size(475.0, 812.0), // Maximum size
      enabled: kIsWeb, // default is enable, when disable content is full size
      backgroundColor: Colors.grey,
    );
  }
}
