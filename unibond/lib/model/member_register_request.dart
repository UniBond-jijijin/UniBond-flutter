import 'package:json_annotation/json_annotation.dart';
import 'member_request.dart';

part 'member_register_request.g.dart';

// 회원가입 POST를 위한 모델
@JsonSerializable()
class MemberRegisterRequest {
  final MemberRequest request;

  MemberRegisterRequest({
    required this.request,
  });

  factory MemberRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRegisterRequestToJson(this);
}
