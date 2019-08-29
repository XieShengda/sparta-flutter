import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/requset/req_login.dart';
import 'package:sparta/core/models/beans/requset/req_login_by_code.dart';
import 'package:sparta/core/models/beans/requset/req_register.dart';
import 'package:sparta/core/models/beans/requset/req_sms.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/networking/response/error.dart';

///common
class AuthRequestingAction {
  final AuthRequestType requestType;

  AuthRequestingAction(this.requestType);
}

class AuthSuccessAction {
  final AuthInfo authInfo;
  final AuthRequestType requestType;

  AuthSuccessAction(this.authInfo, this.requestType);
}

class AuthErrorAction {
  final AuthRequestType requestType;
  final HttpError error;

  AuthErrorAction(this.requestType, this.error);
}

///sms
class ReqSmsAction {
  final ReqSms reqSms;

  ReqSmsAction(this.reqSms);
}

class SmsSuccessAction {
  final SmsInfo smsInfo;

  SmsSuccessAction(this.smsInfo);
}

class SmsInitAction {}

///register
class ReqRegisterAction {
  final ReqRegister reqRegister;

  ReqRegisterAction(this.reqRegister);
}

///login
class ReqLoginAction {
  final ReqLogin reqLogin;

  ReqLoginAction(this.reqLogin);
}

///login by code
class ReqLoginByCodeAction {
  final ReqLoginByCode reqLoginByCode;

  ReqLoginByCodeAction(this.reqLoginByCode);
}
