import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarShower {
  ///Scaffold => Builder(context)
  static text(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
