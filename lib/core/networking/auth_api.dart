import 'package:sparta/core/models/beans/auth_info.dart';
import 'package:sparta/core/models/beans/requset/req_login.dart';
import 'package:sparta/core/models/beans/requset/req_register.dart';
import 'package:sparta/core/models/beans/requset/req_sms.dart';
import 'package:sparta/core/models/beans/sms_info.dart';
import 'package:sparta/core/networking/common/http_client.dart';

class AuthApi {
  final HttpClient client = HttpClient.getInstance();

  Future<SmsInfo> fetchSms(body) async {
    return SmsInfo.fromJson(await client.post('/system/sms', data: body));
  }

  Future<AuthInfo> login(body) async {
    return AuthInfo.fromJson(await client.post('/user/login', data: body));
  }

  Future<AuthInfo> register(body) async {
    return AuthInfo.fromJson(
        await client.post('/user/register', data: body.toJson()));
  }

  Future<AuthInfo> loginByCode(body) async {
    return AuthInfo.fromJson(
        await client.post('/user/loginByCode', data: body.toJson()));
  }
}
