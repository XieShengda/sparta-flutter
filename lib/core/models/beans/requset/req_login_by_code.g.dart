// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_login_by_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqLoginByCode _$ReqLoginByCodeFromJson(Map<String, dynamic> json) {
  return ReqLoginByCode(
    mobile: json['mobile'] as String,
    validCode: json['validCode'] as String,
    msgId: json['msgId'] as String,
  );
}

Map<String, dynamic> _$ReqLoginByCodeToJson(ReqLoginByCode instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'validCode': instance.validCode,
      'msgId': instance.msgId,
    };
