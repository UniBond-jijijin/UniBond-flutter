import 'package:json_annotation/json_annotation.dart';

part 'member_update_request.g.dart';

@JsonSerializable()
class MemberUpdateRequest {
  final int? diseaseId;
  final String? diseaseTiming;
  final String? gender;
  final String? nickname;
  final String? bio;
  final List<String>? interestList;

  MemberUpdateRequest({
    this.diseaseId,
    this.diseaseTiming,
    this.gender,
    this.nickname,
    this.bio,
    this.interestList,
  });

  factory MemberUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MemberUpdateRequestToJson(this);
}
