String? notEmptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field cannot be left empty';
  }
  return null; // valid input
}

// String? emailValidator(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return 'This field cannot be left empty';
//   }

//   final trimmedValue = value.trim();

//   // You can adjust this regex if you want stricter validation
//   final isValidGmail = RegExp(r'^[\w-\.]+@gmail\.com$').hasMatch(trimmedValue);

//   if (!isValidGmail) {
//     return 'Please enter a valid Gmail address';
//   }

//   return null; // valid input
// }
String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field cannot be left empty';
  }

  final trimmedValue = value.trim();

  // General email pattern: must contain '@' and domain parts
  final isValidEmail =
      RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(trimmedValue);

  if (!isValidEmail) {
    return 'Please enter a valid email address';
  }

  return null;
}
