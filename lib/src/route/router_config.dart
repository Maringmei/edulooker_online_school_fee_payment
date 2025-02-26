import 'package:edulooker_online_school_fee_payment/src/core/constants/images/images_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/route/router_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../core/storage/storage.dart';
import '../core/utils/validate_token.dart';
import '../feature/user/home_page/presentation/pages/home_page.dart';
import '../feature/user/login_page/presentation/pages/login_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      redirect: (context, state) async {
        String? token = await Store.getToken();
        if (token == null) {
          return null;
        } else {
          return RouteList.home;
        }
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
        path: '/expire',
        builder: (context, state) => Container(
              child: Center(
                child: ElevatedButton(onPressed: () {}, child: Text("Clear")),
              ),
            )),
  ],
  redirect: (context, state) async {
    String? token = await Store.getToken();
    if (token != null) {
      bool isTokenExp = isTokenExpired(token);
      if (isTokenExp) {
        return RouteList.login;
      } else {
        return null;
      }
    } else {
      return RouteList.login;
    }
  },
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            KImage.expire,
            width: 200,
            height: 200,
          ),
          Gap(5),
          TextWidget(
            text: "Whoops, Session expired.",
            fontSize: 20,
            fontWeight: 700,
          ),
          Gap(5),
          TextWidget(
              text: "Please log in again.", fontSize: 15, fontWeight: 700),
          Gap(10),
          ElevatedButton(
            onPressed: () {
              Store.clear();
              context.go(RouteList.login);
            },
            child: TextWidget(
              text: "Login",
              fontSize: 15,
              fontWeight: 700,
            ),
          ),
        ],
      )),
    ),
  ),
  // redirect: (context, state) async {
  //   String? token = await Store.getToken();
  //   if (token != null) {
  //     bool isTokenExp = isTokenExpired(token);
  //     if (!isTokenExp) {
  //       return RouteList.login;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return RouteList.login;
  //   }
  // },
);
