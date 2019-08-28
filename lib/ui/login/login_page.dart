import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/ui/common/router.dart';
import 'package:sparta/ui/common/snack_bar.dart';
import 'package:sparta/ui/login/login_content_form.dart';

import '../common/platform_adaptive_progress_indicator.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => StoreConnector(
          onDidChange: (Store<AppState> store) {
            switch (
                store.state.authState.requestStatus[AuthRequestType.login]) {
              case LoadingStatus.error:
                SnackBarShower.text(context,
                    store.state.authState.error[AuthRequestType.login].message);
                break;
              case LoadingStatus.success:
                SnackBarShower.text(context, 'Login Success');
                Router.home(context);
                break;
              default:
            }
          },
          converter: (Store<AppState> store) => store,
          builder: (BuildContext context, Store<AppState> store) => Stack(
            children: _buildStack(store),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStack(Store<AppState> store) {
    var widgets = <Widget>[
      LoginContentForm(
        store: store,
      ),
    ];
    if (store.state.authState.requestStatus[AuthRequestType.login] ==
        LoadingStatus.loading) {
      widgets.add(Container(
        alignment: Alignment.center,
        color: Color.fromARGB(128, 0, 0, 100),
        child: PlatformAdaptiveProgressIndicator(),
      ));
    }
    return widgets;
  }
}
