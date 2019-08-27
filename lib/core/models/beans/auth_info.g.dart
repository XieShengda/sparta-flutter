// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) {
  return AuthInfo(
    token: json['token'] as String,
    secretKey: json['secretKey'] as String,
  );
}

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
      'token': instance.token,
      'secretKey': instance.secretKey,
    };
