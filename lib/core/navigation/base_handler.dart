import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class BaseHandler extends Handler {
  BaseHandler({
    HandlerType type = HandlerType.route,
    required this.baseHandlerFunc,
    required this.routeName,
    this.authGuard = false,
  }) : super(type: type, handlerFunc: baseHandlerFunc);

  final HandlerFunc baseHandlerFunc;
  final String routeName;
  final bool authGuard;

  @override
  HandlerFunc get handlerFunc => handlerCallback;

  Widget? handlerCallback(
      BuildContext? context, Map<String, List<String>> parameters) {
    if (authGuard) {
      /// TODO : check user session
      if (true) {
        return baseHandlerFunc.call(context, parameters);
      } else {
        return openIntermediateRoute(parameters, context?.settings?.arguments);
      }
    }
    return baseHandlerFunc.call(context, parameters);
  }

  Widget openIntermediateRoute(
      Map<String, List<String>> parameters, Object? arguments) {
    return ErrorWidget(Exception());
  }
}
