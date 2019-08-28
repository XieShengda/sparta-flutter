import 'package:meta/meta.dart';
import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
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
    this.hasLogin,
  });

  final AuthInfo authInfo;
  final Map<AuthRequestType, LoadingStatus> requestStatus;
  final Map<AuthRequestType, HttpError> error;

  final SmsInfo smsInfo;
  final bool hasLogin;

  factory AuthState.initial() => AuthState(
        authInfo: AuthInfo(token: ApiConfig.GUEST_TOKEN),
        requestStatus: {
          AuthRequestType.sms: LoadingStatus.idle,
          AuthRequestType.register: LoadingStatus.idle,
          AuthRequestType.changePassword: LoadingStatus.idle,
          AuthRequestType.login: LoadingStatus.idle,
        },
        smsInfo: SmsInfo(ApiConfig.DEBUG_MSG_ID),
        error: {},
        hasLogin: false,
      );

  AuthState copyWith({
    AuthInfo authInfo,
    Map<AuthRequestType, LoadingStatus> requestStatus,
    Map<AuthRequestType, HttpError> error,
    SmsInfo smsInfo,
    bool hasLogin,
  }) =>
      AuthState(
        authInfo: authInfo ?? this.authInfo,
        requestStatus: requestStatus ?? this.requestStatus,
        error: error ?? this.error,
        smsInfo: smsInfo ?? this.smsInfo,
        hasLogin: hasLogin ?? this.hasLogin,
      );
}
