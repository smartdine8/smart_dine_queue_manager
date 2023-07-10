import 'package:fluro/fluro.dart';
import 'package:smartdine_queue_manager/core/navigation/route_handlers.dart';

class Routes {
  static const kRouteSplash = '/';
  static const kRouteDashboard = 'dashboard';

  static final _splashRoute =
      AppRoute(Routes.kRouteSplash, splashScreenHandler);
  static final _dashboardRoute =
      AppRoute(Routes.kRouteDashboard, dashBoardScreenHandler);

  static final List<AppRoute> routes = [_splashRoute, _dashboardRoute];
}
