import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparta/core/models/enum/auth_status.dart';
import 'package:sparta/core/redux/store.dart';
import 'package:sparta/ui/common/utils/router.dart';

class BootPage extends StatefulWidget {
  @override
  _BootPageState createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  Timer _timer;
  int _remainSeconds = 6;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainSeconds < 1) {
          timer.cancel();
          var widgetBinding = WidgetsBinding.instance;
          widgetBinding.addPostFrameCallback((duration) {
            print(duration.inMicroseconds);

            _redirection();
          });
        } else {
          _remainSeconds -= 1;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/background_image.jpg',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: RawMaterialButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.all(2),
              fillColor: Colors.white,
              onPressed: _redirection,
              child: Text('$_remainSeconds'),
            ),
          )
        ]);
  }

  void _redirection() {
    if (SpartaStore.global.state.authState.authStatus == AuthStatus.login) {
      Router.home(context);
    } else {
      Router.login(context);
    }
  }
}
