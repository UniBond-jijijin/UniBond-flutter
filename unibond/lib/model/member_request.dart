import 'package:json_annotation/json_annotation.dart';

part 'member_request.g.dart';

// 회원가입 POST, 내 프로필 조회 GET을 위한 모델
@JsonSerializable()
class MemberRequest {
  final int? diseaseId; // 검색 결과가 없는 경우를 대비하여 Null 허용. 예외처리도 구현 필요함.
  final String? diseaseTiming;
  final String nickname;
  final String gender;
  final String bio;
  final List<String> interestList;

  MemberRequest({
    this.diseaseId,
    this.diseaseTiming,
    required this.nickname,
    required this.gender,
    required this.bio,
    required this.interestList,
  });

  factory MemberRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRequestToJson(this);
}
