import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smartdine_queue_manager/core/theme/smartdine_colors.dart';
import 'package:smartdine_queue_manager/core/utils/smartdine_images.dart';

import 'core/core.dart';
import 'core/navigation/navigation_services.dart';
import 'core/navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double height1 = 200;
  double width1 = 200;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        height1 = 320;
        width1 = 3000;
      });
    });
    _navigateUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          height: width1,
          width: height1,
          child: SizedBox(
            width: width1,
            height: height1,
            child: Image.asset(
              SmartDineImages.appLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateUser() async {
    Timer(const Duration(seconds: 3), () async {
      NavigationService().pushAndPopUntil(context, Routes.kRouteDashboard);
    });
  }
}
