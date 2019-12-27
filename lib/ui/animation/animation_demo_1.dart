import 'package:flutter/material.dart';

class AnimationDemo1 extends StatefulWidget {
  @override
  _AnimationDemo1State createState() => _AnimationDemo1State();
}

class _AnimationDemo1State extends State<AnimationDemo1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        child: Hero(
          child: ClipOval(
            child: Image(
              fit: BoxFit.cover,
              width: 200,
              height: 200,
              image: AssetImage('assets/images/background_image.jpg'),
            ),
          ),
          tag: 'avatar',
        ),
        onTap: () =>
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: _buildPage)),
      ),
    );
  }

  Widget _buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: Scaffold(
        appBar: AppBar(
          title: Text('原图'),
        ),
        body: Page2(),
      ),
    );
  }
}

//class Page3 extends StatefulWidget {
//  @override
//  _Page3State createState() => _Page3State();
//}

//class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
//
//  AnimationController controller;
//  CurvedAnimation animation;
//  Animation tween;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    controller = AnimationController(
//        duration: Duration(seconds: 3), vsync: this
//    );
//    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
//    tween
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    controller.dispose();
//    // TODO: implement dispose
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return
//      AnimatedBuilder(
//        animation: ColorTween().animate(controller),
//      )
//    Container(
//      alignment: Alignment.center,
//      child: Hero(
//        tag: 'avatar',
//        child: Image.asset(
//          'assets/images/background_image.jpg', fit: BoxFit.cover,),
//      ),
//    );
//  }
//}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar',
        child: Image.asset(
          'assets/images/background_image.jpg', fit: BoxFit.cover,),
      ),
    );
  }
}
