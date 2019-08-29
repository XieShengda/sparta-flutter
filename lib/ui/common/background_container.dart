import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final List<Widget> children;

  const BackgroundContainer({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/background_image.jpg',
          fit: BoxFit.cover,
        ),
      ]..addAll(children),
    );
  }
}
