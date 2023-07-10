import '../core.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key, required this.failureMessage}) : super(key: key);
  final String failureMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(failureMessage,
            style: const TextStyle(color: Colors.black, fontSize: 16)));
  }
}
