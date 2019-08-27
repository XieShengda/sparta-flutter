import 'package:json_annotation/json_annotation.dart';

part 'req_login.g.dart';

@JsonSerializable()
class ReqLogin {
  final String mobile;
  final String password;

  ReqLogin(this.mobile, this.password);

  Map<String, dynamic> toJson() => _$ReqLoginToJson(this);
}
