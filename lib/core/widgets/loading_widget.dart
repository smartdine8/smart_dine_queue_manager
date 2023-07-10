
import 'package:smartdine_queue_manager/core/extensions/sized_box_extension.dart';
import 'package:smartdine_queue_manager/core/theme/smartdine_colors.dart';

import '../core.dart';

class LoadingWidget {
  static void showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
                color: SmartDineColors.lightPrimaryColor, strokeWidth: 6),
            20.verticalSpace,
            Text("Please wait...",
                style:
                    TextStyle(color: SmartDineColors.lightPrimaryColor)),
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alert);
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
