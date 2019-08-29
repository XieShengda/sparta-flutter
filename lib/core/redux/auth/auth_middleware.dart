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
        _init(action, next);
        break;
      case ReqSmsAction:
        await _fetchSms(action, next);
        break;
      case ReqLoginAction:
        await _login(store, action, next);
        break;
      case ReqRegisterAction:
        await _register(store, action, next);
        break;
      case ReqLoginByCodeAction:
        await _loginByCode(store, action, next);
        break;
      case AuthSuccessAction:
        await _authSuccess(action, next);
        break;
    }
  }

  ///SharedPreference
  AuthInfo _getAuthInfo() {
    AuthInfo authInfo;
    var token = SpartaStore.keyValueStore?.getString(kToken);
    var secretKey = SpartaStore.keyValueStore?.getString(kSecretKey);
    if (token != null && secretKey != null) {
      authInfo = AuthInfo(token: token, secretKey: secretKey);
    }
    debugPrint('get auth info from sp');
    debugPrint(authInfo.toString());
    return authInfo;
  }

  Future<void> _setAuthInfo(AuthInfo authInfo) async {
    debugPrint('set auth info from sp');
    debugPrint(authInfo.toString());
    if (authInfo != null) {
      SpartaStore.keyValueStore?.setString(kToken, authInfo.token);
      SpartaStore.keyValueStore?.setString(kSecretKey, authInfo.secretKey);
    }
  }

  ///init
  _init(action, NextDispatcher next) {
    AuthInfo authInfo = _getAuthInfo();
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
      next(AuthErrorAction(AuthRequestType.sms, e));
      debugPrint(e);
    }
  }

  Future<void> _loginByCode(
      Store<AppState> store, action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.login));
    try {
      AuthInfo authInfo = await api.loginByCode(action.reqLoginByCode);
      store.dispatch(AuthSuccessAction(authInfo, AuthRequestType.login));
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.login, e));
      debugPrint(e);
    }
  }

  Future<void> _login(
      Store<AppState> store, action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.login));
    try {
      AuthInfo authInfo = await api.login(action.reqLogin);
      store.dispatch(AuthSuccessAction(authInfo, AuthRequestType.login));
      debugPrint('login success');
      debugPrint(authInfo.toString());
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.login, e));
      debugPrint(e);
    }
  }

  Future<void> _register(
      Store<AppState> store, action, NextDispatcher next) async {
    next(AuthRequestingAction(AuthRequestType.register));
    try {
      AuthInfo authInfo = await api.register(action.reqRegister);
      store.dispatch(AuthSuccessAction(authInfo, AuthRequestType.register));
    } catch (e) {
      next(AuthErrorAction(AuthRequestType.register, e));
      debugPrint(e);
    }
  }

  Future<void> _authSuccess(action, NextDispatcher next) async {
    _setAuthInfo(action.authInfo);
  }
}
