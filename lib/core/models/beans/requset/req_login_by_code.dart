import 'package:json_annotation/json_annotation.dart';

part 'req_login_by_code.g.dart';

@JsonSerializable()
class ReqLoginByCode {
  final String mobile;
  final String validCode;
  final String msgId;

  ReqLoginByCode({this.mobile, this.validCode, this.msgId});

  Map<String, dynamic> toJson() => _$ReqLoginByCodeToJson(this);
}
