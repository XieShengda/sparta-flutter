//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//import 'package:sparta/core/models/enum/loading_status.dart';
//import 'package:sparta/core/redux/app/app_state.dart';
//import 'package:sparta/core/redux/auth/auth_action.dart';
//import 'package:sparta/res/colors.dart';
//import 'package:sparta/ui/common/utils/snack_bar_util.dart';
//
//class _FrontLayer extends StatelessWidget {
//  const _FrontLayer({Key key, this.onTap, this.child}) : super(key: key);
//
//  final VoidCallback onTap;
//  final Widget child;
//
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      elevation: 0,
//      borderRadius: BorderRadius.only(
//          topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
//      child: Column(
//        children: <Widget>[
//          GestureDetector(
//            behavior: HitTestBehavior.opaque,
//            onTap: onTap,
//            child: Container(
//              height: 60.0,
//            ),
//          ),
//          Expanded(
//            child: child,
//          )
//        ],
//      ),
//    );
//  }
//}
//
///// Builds a Backdrop.
/////
///// A Backdrop widget has two layers, front and back. The front layer is shown
///// by default, and slides down to show the back layer, from which a user
///// can make a selection. The user can also configure the titles for when the
///// front or back layer is showing.
//class Backdrop extends StatefulWidget {
//  final Widget child;
//  final String title;
//  final scaffoldKey;
//
//  const Backdrop(
//      {@required this.child,
//      @required this.title,
//      @required this.scaffoldKey = GlobalKey<ScaffoldState>()})
//      : assert(child != null);
//
//  @override
//  _BackdropState createState() => _BackdropState();
//}
//
//class _BackdropState extends State<Backdrop>
//    with SingleTickerProviderStateMixin {
//  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void didUpdateWidget(Backdrop old) {
//    super.didUpdateWidget(old);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//  final scaffoldKey = GlobalKey<ScaffoldState>()
//  @override
//  Widget build(BuildContext context) {
//    var appBar = AppBar(
//      brightness: Brightness.light,
//      backgroundColor: spartaDarkPrimary,
//      elevation: 0.0,
//      centerTitle: true,
//      titleSpacing: 0.0,
//      title: Text(widget.title),
//      actions: <Widget>[
////        SizedBox(
////          width: 30,
////          height: 30,
////          child: DecoratedBox(
////            decoration: BoxDecoration(
////                borderRadius: BorderRadius.circular(10.0),
////                color: spartaPrimary),
////            child: new IconButton(
////              icon: Icon(
////                Icons.search,
////                semanticLabel: 'search',
////              ),
////              onPressed: () {},
////            ),
////          ),
////        ),
//
//        IconButton(
//          icon: Icon(
//            Icons.search,
//            semanticLabel: 'search',
//          ),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(
//            Icons.tune,
//            semanticLabel: 'login',
//          ),
//          onPressed: () {},
//        ),
//      ],
//    );
//    return
//  }
//}
//
//class DemoDialog extends Dialog {
//  @override
//  Widget build(BuildContext context) {
//    return Material(
////      color: Colors.transparent,
//      child: GestureDetector(
//        child: Image.asset('assets/images/diamond.png'),
//        onTap: () => Navigator.pop(context),
//      ),
//    );
//  }
//}
