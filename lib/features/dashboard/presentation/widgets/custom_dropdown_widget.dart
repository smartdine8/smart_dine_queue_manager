import '../../../../core/core.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key, required this.getSelectedCount});

  final Function(int selectedCount) getSelectedCount;

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedValue,
      items: List.generate(20, (index) => index + 1).map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedValue = newValue ?? 1;
        });
        widget.getSelectedCount(newValue ?? 1);
      },
    );
  }
}
