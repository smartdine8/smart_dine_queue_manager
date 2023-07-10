import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget smallWindow;
  final Widget mediumWindow;
  final Widget largeWindow;

  const Responsive(
      {Key? key,
      required this.smallWindow,
      required this.mediumWindow,
      required this.largeWindow})
      : super(key: key);

  static bool isSmallWindow(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isLargeWindow(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;

  static bool isMediumWindow(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return largeWindow;
      } else if (constraints.maxWidth >= 800) {
        return mediumWindow;
      } else {
        return smallWindow;
      }
    });
  }
}
