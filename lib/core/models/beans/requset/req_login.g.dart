// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqLogin _$ReqLoginFromJson(Map<String, dynamic> json) {
  return ReqLogin(
    json['mobile'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$ReqLoginToJson(ReqLogin instance) => <String, dynamic>{
      'mobile': instance.mobile,
      'password': instance.password,
    };
