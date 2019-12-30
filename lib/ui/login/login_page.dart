import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/auth_status.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/ui/common/utils/router.dart';
import 'package:sparta/ui/common/utils/snack_bar_util.dart';
import 'package:sparta/ui/common/widgets/platform_adaptive_progress_indicator.dart';

import 'login_valid_code.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: _onInit,
      converter: (Store<AppState> store) => store,
      builder: _buildLogin,
      onDidChange: _onDidChange,
    );
  }

  void _onInit(Store<AppState> store) {
    switch (store.state.authState.authStatus) {
      case AuthStatus.logout:
        SnackBarUtil.textByKey(scaffoldKey, '已登出');

        ///清除授权信息
        store.dispatch(ClearAuthAction());
        break;
      case AuthStatus.invalid:
        SnackBarUtil.textByKey(scaffoldKey, '登录信息失效, 请重新登陆');
        store.dispatch(ClearAuthAction());
        break;
      default:
    }
  }

  _onDidChange(Store<AppState> store) {
    switch (store.state.authState.requestStatus[AuthRequestType.login]) {
      case LoadingStatus.error:
        SnackBarUtil.textByKey(scaffoldKey,
            store.state.authState.error[AuthRequestType.login].message);
        store.dispatch(InitAuthRequestStatusAction());
        break;
      case LoadingStatus.success:
        Router.toHome(context); //跳转到主页之后初始化请求状态
        break;
      default:
    }
  }

  Widget _buildLogin(BuildContext context, Store<AppState> store) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          LoginValidCode(
            store: store,
          ),
          store.state.authState.requestStatus[AuthRequestType.login] ==
                  LoadingStatus.loading
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.lime.withOpacity(0.8),
                  child: PlatformAdaptiveProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
