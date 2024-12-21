import 'package:edulooker_online_school_fee_payment/src/route/router_list.dart';
import 'package:flutter/material.dart';
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
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
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
);
