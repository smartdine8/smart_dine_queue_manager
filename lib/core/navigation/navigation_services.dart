import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:smartdine_queue_manager/core/navigation/route_matcher.dart';

import 'navigation_observer.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService _instance = NavigationService._();

  factory NavigationService() => _instance;

  Future<dynamic> pushWithArguments(
    BuildContext context,
    String routePath, {
    Object? arguments,
  }) async {
    return await FluroRouter.appRouter.navigateTo(
      context,
      routePath,
      routeSettings: RouteSettings(name: routePath, arguments: arguments),
    );
  }

  Future<dynamic> push(
    BuildContext context,
    String routePath,
  ) async {
    return await FluroRouter.appRouter.navigateTo(
      context,
      routePath,
      routeSettings: RouteSettings(name: routePath),
    );
  }

  pop(BuildContext context) {
    FluroRouter.appRouter.pop(context);
  }

  popUntil(BuildContext context, String routePath) {
    bool isExactRoute = false;
    Navigator.popUntil(context, (route) {
      if (route.settings.name == routePath) {
        isExactRoute = true;
      }
      return isExactRoute;
    });
  }

  Future<dynamic> pushAndPopUntil(BuildContext context, String routePath,
      {Object? arguments}) async {
    return await FluroRouter.appRouter.navigateTo(
      context,
      routePath,
      clearStack: true,
      routeSettings: RouteSettings(name: routePath, arguments: arguments),
    );
  }

  bool containsOnGlobalRouteStack(String routeName, BuildContext context) {
    final routeMatchPredicate = RouteMatcher.matchParameterizedRoute(routeName);
    for (final route in routeStack) {
      if (route == null) continue;
      final bool exists = routeMatchPredicate(route);
      if (exists) {
        return true;
      }
    }
    return false;
  }
}
