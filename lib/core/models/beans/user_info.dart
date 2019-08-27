import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';
@JsonSerializable()
class UserInfo{
  final String mobile;
  final String nickname;
  final String avatar;

  UserInfo(this.mobile, this.nickname, this.avatar);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}