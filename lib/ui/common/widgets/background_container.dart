import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final List<Widget> children;

  const BackgroundContainer({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
//        Image.asset(
//          'assets/images/background_image.jpg',
//          fit: BoxFit.cover,
//        ),
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:<Color>[Colors.yellow, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomCenter )
        ),
      )
      ]..addAll(children),
    );
  }
}
