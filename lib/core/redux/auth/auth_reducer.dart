import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/auth_status.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/common/common_action.dart';

import 'auth_action.dart';
import 'auth_state.dart';

AuthState authReducer(AuthState state, action) {
  switch (action.runtimeType) {
    case InitCompleteAction:
      return state.copyWith(
          authInfo: action.authInfo, authStatus: AuthStatus.login);

    case AuthRequestingAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.loading;
      return state.copyWith(requestStatus: requestStatus);

    case InitAuthRequestStatusAction:
      return state.copyWith(requestStatus: AuthState.initialRequestStatus);

    case SmsSuccessAction:
      var requestStatus = state.requestStatus;
      requestStatus[AuthRequestType.sms] = LoadingStatus.success;
      return state.copyWith(
          requestStatus: requestStatus, smsInfo: action.smsInfo);

    case AuthSuccessAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.success;
      return state.copyWith(
          authInfo: action.authInfo,
          requestStatus: requestStatus,
          authStatus: AuthStatus.login);

    case AuthErrorAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.error;
      var error = state.error;
      error[action.requestType] = action.error;
      return state.copyWith(requestStatus: requestStatus, error: error);

    case LogoutAction:
      return state.copyWith(authStatus: AuthStatus.logout);

    case InvalidAuthAction:
      return state.copyWith(authStatus: AuthStatus.invalid);

    case ClearAuthAction:
      return AuthState.initial();

    default:
      return state;
  }
}
