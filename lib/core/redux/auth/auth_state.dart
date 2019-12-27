import 'package:meta/meta.dart';
import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/auth_status.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/networking/config/api_config.dart';
import 'package:sparta/core/networking/response/error.dart';

@immutable
class AuthState {
  AuthState({
    this.authInfo,
    this.requestStatus,
    this.error,
    this.smsInfo,
    this.authStatus,
  });

  final AuthInfo authInfo;
  final Map<AuthRequestType, LoadingStatus> requestStatus;
  final Map<AuthRequestType, HttpError> error;

  final SmsInfo smsInfo;
  final AuthStatus authStatus;

  factory AuthState.initial() => AuthState(
        authInfo: AuthInfo(token: ApiConfig.GUEST_TOKEN),
        requestStatus: initialRequestStatus,
        smsInfo: null,
        error: {},
        authStatus: AuthStatus.initial,
      );

  AuthState copyWith(
          {AuthInfo authInfo,
          Map<AuthRequestType, LoadingStatus> requestStatus,
          Map<AuthRequestType, HttpError> error,
          SmsInfo smsInfo,
          AuthStatus authStatus}) =>
      AuthState(
        authInfo: authInfo ?? this.authInfo,
        requestStatus: requestStatus ?? this.requestStatus,
        error: error ?? this.error,
        smsInfo: smsInfo ?? this.smsInfo,
        authStatus: authStatus ?? this.authStatus,
      );

  static Map<AuthRequestType, LoadingStatus> get initialRequestStatus {
    return {
      AuthRequestType.sms: LoadingStatus.idle,
      AuthRequestType.register: LoadingStatus.idle,
      AuthRequestType.changePassword: LoadingStatus.idle,
      AuthRequestType.login: LoadingStatus.idle,
    };
  }
}
