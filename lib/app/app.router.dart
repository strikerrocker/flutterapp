// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../db/tables.dart';
import '../ui/views/cart/cart_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String signupView = '/signup-view';
  static const String cartView = '/cart-view';
  static const all = <String>{
    startupView,
    loginView,
    homeView,
    signupView,
    cartView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.cartView, page: CartView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          user: args.user,
        ),
        settings: data,
      );
    },
    SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignupView(),
        settings: data,
      );
    },
    CartView: (data) {
      var args = data.getArgs<CartViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CartView(
          key: args.key,
          user: args.user,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  final User user;
  HomeViewArguments({this.key, required this.user});
}

/// CartView arguments holder class
class CartViewArguments {
  final Key? key;
  final User user;
  CartViewArguments({this.key, required this.user});
}
