import 'package:fluro/fluro.dart';
import 'package:smartdine_queue_manager/core/navigation/routes.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../splash_screen.dart';
import '../core.dart';
import 'base_handler.dart';

final notFoundHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
    return ErrorWidget('Page Not found.');
  },
);

final splashScreenHandler = BaseHandler(
  routeName: Routes.kRouteSplash,
  baseHandlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
    return const SplashScreen();
  },
);
final dashBoardScreenHandler = BaseHandler(
  routeName: Routes.kRouteDashboard,
  authGuard: false,
  baseHandlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
    return  DashBoardPage();
  },
);
