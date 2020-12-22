import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    if (arguments == null) {
      return navigatorKey.currentState.pushNamed(routeName);
    }
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> pop() {
    navigatorKey.currentState.pop();
    return null;
  }
}
