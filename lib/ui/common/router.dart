import 'package:flutter/cupertino.dart';

class Router {
  static home(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (route) => route == null);
  }

  static login(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (route) => route == null);
  }
}
