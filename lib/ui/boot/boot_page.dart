import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/ui/common/router.dart';

class BootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store<AppState> store) async {
        await Future.delayed(Duration(seconds: 2), () {
          if (store.state.authState.hasLogin) {
            //todo change
//            Router.home(context);
            Router.login(context);

          } else {
            Router.login(context);
          }
        });
      },
      converter: (store) => store,
      builder: (context, store) => Container(
        color: Colors.lime,
        alignment: Alignment.center,
        child: Text('Boot'.toUpperCase()),
      ),
    );
  }
}
