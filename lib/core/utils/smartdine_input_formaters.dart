import 'package:flutter/services.dart';

class SmartDineInputFormatters {
  static TextInputFormatter kOnlyAlphabetsFormatter =
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
  static TextInputFormatter kOnlyNumberFormatter =
      FilteringTextInputFormatter.allow(RegExp("[0-9]"));
}
