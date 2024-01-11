import 'package:json_annotation/json_annotation.dart';

part 'member_update_request.g.dart';

// 내 프로필 수정 POST를 위한 모델
@JsonSerializable()
class MemberUpdateRequest {
  final int? diseaseId;
  final String? diagnosisTiming;
  final String? gender;
  final String? nickname;
  final String? bio;
  final List<String>? interestList;

  MemberUpdateRequest({
    this.diseaseId,
    this.diagnosisTiming,
    this.gender,
    this.nickname,
    this.bio,
    this.interestList,
  });

  factory MemberUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MemberUpdateRequestToJson(this);
}
