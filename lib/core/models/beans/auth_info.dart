import 'package:json_annotation/json_annotation.dart';

part 'auth_info.g.dart';

@JsonSerializable()
class AuthInfo {
  final String token;
  final String secretKey;

  AuthInfo({this.token, this.secretKey});

  factory AuthInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoFromJson(json);

  @override
  String toString() {
    return 'AuthInfo{token: $token, secretKey: $secretKey}';
  }

}
