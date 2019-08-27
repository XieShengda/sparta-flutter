// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqRegister _$ReqRegisterFromJson(Map<String, dynamic> json) {
  return ReqRegister(
    json['mobile'] as String,
    json['password'] as String,
    json['validCode'] as String,
    json['msgId'] as String,
  );
}

Map<String, dynamic> _$ReqRegisterToJson(ReqRegister instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'password': instance.password,
      'validCode': instance.validCode,
      'msgId': instance.msgId,
    };
