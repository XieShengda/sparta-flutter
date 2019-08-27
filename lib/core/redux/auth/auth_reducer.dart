import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/common/common_action.dart';

import 'auth_action.dart';
import 'auth_state.dart';

AuthState authReducer(AuthState state, action) {
  switch (action.runtimeType) {
    case InitCompleteAction:
      return state.copyWith(authInfo: action.authInfo, hasLogin: true);
    case AuthRequestingAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.loading;
      return state.copyWith(requestStatus: requestStatus);
    case SmsSuccessAction:
      return state.copyWith(smsInfo: action.smsInfo);
    case AuthSuccessAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.success;
      return state.copyWith(
          authInfo: action.authInfo,
          requestStatus: requestStatus,
          hasLogin: true);
    case AuthErrorAction:
      var requestStatus = state.requestStatus;
      requestStatus[action.requestType] = LoadingStatus.error;
      return state.copyWith(requestStatus: requestStatus);
    default:
      return state;
  }
}
