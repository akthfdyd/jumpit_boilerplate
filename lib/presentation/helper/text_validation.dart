import 'package:arc/arc.dart';

String passwordValidation(String str) {
  if (str.isNullOrEmpty) {
    return "";
  } else if (str.length < 8) {
    return "at least 8 characters";
  } else {
    return "good password";
  }
}
