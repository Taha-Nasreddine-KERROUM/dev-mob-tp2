String? emailValidationFct(String? value) {
  const pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return "Email can't be empty";
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? pwdValidationFct(String? value) {
  const pattern = r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[@#\&*~]).{8,}';
  final regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return "Password can't be empty";
  } else if (!regex.hasMatch(value)) {
    return 'The password must be at least 8 characters\nand should contain at least one uppercase,\none digit, one special character among (@#\&*~)';
  }
  return null;
}

String? pwdConfirmValidationFct(String? value, String password) {
  if (value == null || value.isEmpty) {
    return "Confirm password can't be empty";
  } else if (value != password) {
    return 'Confirm password should be the same as password';
  }
  return null;
}

String? usernameValidationFct(String? value) {
  if (value == null || value.isEmpty) {
    return "Username can't be empty";
  }
  return null;
}

String? fieldValidationFct(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName can't be empty";
  }
  return null;
}