import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

// 내 프로필 GET
@JsonSerializable()
class UserProfile {
  final bool isSuccess;
  final int code;
  final String message;
  final UserProfileResult result;

  UserProfile({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UserProfileResult {
  final String profileImage;
  final String nickname;
  final String gender;
  final String diseaseName;
  final String diagnosisTiming;
  final String bio;
  final List<String> interestList;

  UserProfileResult({
    required this.profileImage,
    required this.nickname,
    required this.gender,
    required this.diseaseName,
    required this.diagnosisTiming,
    required this.bio,
    required this.interestList,
  });

  factory UserProfileResult.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResultToJson(this);
}
