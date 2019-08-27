import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'req_sms.g.dart';

@JsonSerializable()
class ReqSms {
  final String mobile;
  final int type;

  ReqSms({@required this.mobile, @required this.type});

  Map<String, dynamic> toJson() => _$ReqSmsToJson(this);
}
