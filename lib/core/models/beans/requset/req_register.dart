import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'req_register.g.dart';

@JsonSerializable()
class ReqRegister {

  final String mobile;
  final String password;
  final String validCode;
  final String msgId;

  ReqRegister(this.mobile, this.password, this.validCode, this.msgId);

  Map<String, dynamic> toJson() => _$ReqRegisterToJson(this);


}
