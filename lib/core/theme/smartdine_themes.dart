
import '../core.dart';

class SmartDineThemes {
  static ThemeData lightTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(size: 24));
  static ThemeData darkTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.white.withOpacity(.7),
      iconTheme: const IconThemeData(size: 24));
}
