import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/enum/auth_status.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/ui/common/utils/router.dart';

class AuthChecker {
  ///检查登录状态
  static check(BuildContext context, Store<AppState> store) {
    final authState = store.state.authState.authStatus;
    if (authState != AuthStatus.initial && authState != AuthStatus.login) {
      Router.toLogin(context);
    }
  }
}
