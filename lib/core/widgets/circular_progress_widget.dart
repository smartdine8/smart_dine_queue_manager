import '../core.dart';
import '../theme/smartdine_colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
            strokeWidth: 5, color: SmartDineColors.lightPrimaryColor),
      ),
    );
  }
}
