import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Push a new route by widget
  static Future<dynamic>? push(Widget page) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push named route
  static Future<dynamic>? pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  /// Replace with new route by widget
  static Future<dynamic>? pushReplacement(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Replace with named route
  static Future<dynamic>? pushReplacementNamed(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Remove all previous routes and push
  static Future<dynamic>? pushAndRemoveUntilNamed(String routeName) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  /// Remove all previous routes and pushNamed
  static Future<dynamic>? pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop current screen
  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  /// Check if can pop
  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }
}
