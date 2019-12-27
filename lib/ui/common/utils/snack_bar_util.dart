import 'package:flutter/material.dart';

class SnackBarUtil {
  ///Scaffold => Builder(context)
  static textByContext(BuildContext context, String text) async {
    Scaffold.of(context)?.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  static textByKey(GlobalKey<ScaffoldState> key, String text) async {
    if (key == null) return;
    while (key.currentState == null) {
      await Future.delayed(Duration.zero);
    }
    key.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
