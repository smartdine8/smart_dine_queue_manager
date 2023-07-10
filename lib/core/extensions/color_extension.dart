import '../theme/smartdine_colors.dart';
import '../core.dart';
extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    return hexColor.length < 6 || hexColor.length > 8
        ? SmartDineColors.blackColor
        : Color(int.parse("0xFF$hexColor"));
  }
}
