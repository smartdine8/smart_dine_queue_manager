import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core.dart';
import '../enums/smartdine_flavors_enum.dart';

class FlavorSetup {
  static setupFlavorForEnvironment(FlavorEnum flavor) async {
    if (flavor == FlavorEnum.PROD) {
      await dotenv.load(fileName: "prod.env");
    } else if (flavor == FlavorEnum.DEV) {
      await dotenv.load(fileName: "dev.env");
    } else {
      debugPrint('Unknown Environment');
    }
  }
}
