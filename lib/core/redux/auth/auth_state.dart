import 'package:meta/meta.dart';
import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/networking/config/api_config.dart';

@immutable
class AuthState {
  AuthState({this.authInfo, this.requestStatus, this.smsInfo, this.hasLogin});

  final AuthInfo authInfo;
  final Map<AuthRequestType, LoadingStatus> requestStatus;
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
      hasLogin: false);

  AuthState copyWith(
          {AuthState authInfo,
          Map<AuthRequestType, LoadingStatus> requestStatus,
          SmsInfo smsInfo,
          bool hasLogin}) =>
      AuthState(
          authInfo: authInfo ?? this.authInfo,
          requestStatus: requestStatus ?? this.requestStatus,
          smsInfo: smsInfo ?? this.smsInfo,
          hasLogin: hasLogin ?? this.hasLogin);
}
