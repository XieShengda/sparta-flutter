// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqSms _$ReqSmsFromJson(Map<String, dynamic> json) {
  return ReqSms(
    mobile: json['mobile'] as String,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$ReqSmsToJson(ReqSms instance) => <String, dynamic>{
      'mobile': instance.mobile,
      'type': instance.type,
    };
