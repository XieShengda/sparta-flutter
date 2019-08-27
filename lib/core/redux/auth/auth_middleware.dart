import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/networking/auth_api.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/common/common_action.dart';
import 'package:sparta/core/redux/store.dart';

import 'auth_action.dart';

class AuthMiddleWare extends MiddlewareClass<AppState> {
  static const kToken = 'token';
  static const kSecretKey = 'secretKey';
  final AuthApi api;

  AuthMiddleWare(this.api);

  @override
  Future<void> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    switch (action.runtimeType) {
      case InitAction:
        await _init(action, next);
        break;
      case ReqSmsAction:
        await _fetchSms(action, next);
        break;
      case ReqLoginAction:
        await _login(action, next);
        break;
      case ReqRegisterAction:
        await _register(action, next);
        break;
      case AuthSuccessAction:
        await _authSuccess(action, next);
        break;
    }
  }

  Future<AuthInfo> _getAuthInfo() async {
    AuthInfo authInfo;
    var keyValueStore = await SpartaStore.getKeyValueStore();
    var token = keyValueStore.getString(kToken);
    var secretKey = keyValueStore.getString(kSecretKey);
    if (token != null && secretKey != null) {
      authInfo = AuthInfo(token: token, secretKey: secretKey);
    }
    return authInfo;
  }

  Future<void> _setAuthInfo(AuthInfo authInfo) async {
    if (authInfo != null) {
      var keyValueStore = await SpartaStore.getKeyValueStore();
      keyValueStore.setString(kToken, authInfo.token);
      keyValueStore.setString(kSecretKey, authInfo.secretKey);
    }
  }

  Future<void> _init(action, NextDispatcher next) async {
    AuthInfo authInfo = await _getAuthInfo();
    if (authInfo != null) {
      next(InitCompleteAction(authInfo: authInfo));
    }
  }

  Future<void> _fetchSms(action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.sms));
    try {
      SmsInfo smsInfo = await api.fetchSms(action.reqSms);
      next(SmsSuccessAction(smsInfo));
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.sms));
      debugPrint(e);
    }
  }

  Future<void> _login(action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.login));
    try {
      AuthInfo authInfo = await api.login(action.reqLogin);
      next(AuthSuccessAction(authInfo, AuthRequestType.login));
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.login));
      debugPrint(e);
    }
  }

  Future<void> _register(action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.register));
    try {
      AuthInfo authInfo = await api.register(action.reqRegister);
      next(AuthSuccessAction(authInfo, AuthRequestType.register));
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.register));
      debugPrint(e);
    }
  }

  Future<void> _authSuccess(action, NextDispatcher next) async {
    _setAuthInfo(action.authInfo);
  }
}
