class SmartDineValidators {
  SmartDineValidators._();

  static final SmartDineValidators _instance = SmartDineValidators._();

  factory SmartDineValidators() => _instance;

  bool isEmailValid(String em) {
    const Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern as String);
    return regex.hasMatch(em);
  }

  String? firstNameTextFieldValidator(String value) {
    if (value.toString().trim().isEmpty) {
      return 'First name is empty';
    }
    return null;
  }

  String? emailTextFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return "Please enter Email";
    } else if (!SmartDineValidators().isEmailValid(value.trim())) {
      return "Please enter valid email.";
    }
    return null;
  }
}
