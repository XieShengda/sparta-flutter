import 'package:json_annotation/json_annotation.dart';

part 'sms_info.g.dart';

@JsonSerializable()
class SmsInfo {
  final String msgId;

  SmsInfo(this.msgId);

  factory SmsInfo.fromJson(Map<String, dynamic> json) =>
      _$SmsInfoFromJson(json);
}
