import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartdine_queue_manager/core/theme/smartdine_themes.dart';
import 'package:smartdine_queue_manager/core/utils/smartdine_string_constants.dart';
import 'package:smartdine_queue_manager/features/dashboard/dashboard_dependency_injection.dart';
import 'package:smartdine_queue_manager/splash_screen.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/enums/smartdine_flavors_enum.dart';
import 'core/flavors/flavor_setup.dart';
import 'core/navigation/app_router.dart';
import 'core/navigation/navigation_observer.dart';
import 'core/navigation/routes.dart';
import 'core/utils/globals.dart' as globals;

void main() async {
  // use env variable like this :
  // print('Building app with Flavor : ${dotenv.env['FLAVOR_NAME']}');
  //await FlavorSetup.setupFlavorForEnvironment(FlavorEnum.DEV);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBKZo4sJjYPy79YMKv8RmKRc0taj83g5mA',
          appId: '1:118404131771:web:8a930d67a2b58185a5729e',
          messagingSenderId: '118404131771',
          projectId: 'smartdine-878e8'));

  await _injectDependencies();
  runApp(const MyApp());
}

Future<void> _injectDependencies() async {
  await Future.wait([dashBoardInit()]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter.instance();
    appRouter.setupRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globals.navigatorKey,
      title: SmartDineStringConstants.appName,
      theme: SmartDineThemes.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.kRouteSplash,
      onGenerateRoute: appRouter.onGenerateRoutes,
      navigatorObservers: [NavigationObserver()],
      home: const SplashScreen(),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      // localeResolutionCallback: (locale, supportedLocales) {
      //   // Check if the current device locale is supported
      //   for (final supportedLocale in supportedLocales) {
      //     if (supportedLocale.languageCode == locale!.languageCode &&
      //         supportedLocale.countryCode == locale.countryCode) {
      //       return supportedLocale;
      //     }
      //   }
      //
      //   /// Add your logic to get language
      //   return supportedLocales.first;
      // },
    );
  }
}
