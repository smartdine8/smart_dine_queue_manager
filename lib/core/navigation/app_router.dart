import 'package:fluro/fluro.dart';
import 'package:smartdine_queue_manager/core/navigation/route_handlers.dart';
import 'package:smartdine_queue_manager/core/navigation/routes.dart';


import '../core.dart';

class AppRouter {
  AppRouter({
    required List<AppRoute> routes,
    required Handler notFoundHandler,
  })  : _routes = routes,
        _notFoundHandler = notFoundHandler;

  static FluroRouter router = FluroRouter.appRouter;

  final List<AppRoute> _routes;
  final Handler _notFoundHandler;

  List<AppRoute> get routes => _routes;

  static AppRouter? _instance;

  factory AppRouter.instance() {
    return _instance ??
        AppRouter(
          routes: Routes.routes,
          notFoundHandler: notFoundHandler,
        );
  }

  void setupRoutes() {
    router.notFoundHandler = _notFoundHandler;
    for (var route in routes) {
      router.define(route.route, handler: route.handler as Handler);
    }
  }

  Route<dynamic>? onGenerateRoutes(RouteSettings routeSettings) {
    final newRouteSettings = routeSettingsBasedOnGuard(routeSettings);
    return FluroRouter.appRouter.generator.call(newRouteSettings);
  }

  RouteSettings routeSettingsBasedOnGuard(RouteSettings actualRouteSettings) {
    return actualRouteSettings;
  }
}
