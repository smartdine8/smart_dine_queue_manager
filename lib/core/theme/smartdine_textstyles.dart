import 'package:flutter/material.dart';

import '../enums/smartdine_font_family_enum.dart';
import 'smartdine_colors.dart';

class SmartDineTextStyles {
  /// dark theme
  static TextStyle whiteLargeText = TextStyle(
      color: SmartDineColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: SmartDineFontFamily.Roboto.name);
  static TextStyle whiteMediumText = TextStyle(
      color: SmartDineColors.blackColor,
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
      fontFamily: SmartDineFontFamily.Roboto.name);

  /// light theme
  static TextStyle blackLargeText = TextStyle(
      color: SmartDineColors.lightBlueColor,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontFamily: SmartDineFontFamily.Roboto.name);

  static TextStyle blackMediumText = TextStyle(
      color: SmartDineColors.lightOrangeColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w800,
      fontFamily: SmartDineFontFamily.Roboto.name);

  static TextStyle greyMediumText = TextStyle(
      color: SmartDineColors.lightPrimaryColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w800,
      fontFamily: SmartDineFontFamily.Roboto.name);
}
