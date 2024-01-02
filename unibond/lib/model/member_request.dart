import 'package:json_annotation/json_annotation.dart';

part 'member_request.g.dart';

// 회원가입 POST, 내 프로필 조회 GET을 위한 모델
@JsonSerializable()
class MemberRequest {
  final int diseaseId;
  final String diseaseTiming;
  final String nickname;
  final String gender;
  final String bio;
  final List<String> interestList;

  MemberRequest({
    required this.diseaseId,
    required this.diseaseTiming,
    required this.nickname,
    required this.gender,
    required this.bio,
    required this.interestList,
  });

  factory MemberRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRequestToJson(this);
}
