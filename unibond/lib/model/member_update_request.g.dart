// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberUpdateRequest _$MemberUpdateRequestFromJson(Map<String, dynamic> json) =>
    MemberUpdateRequest(
      diseaseId: json['diseaseId'] as int?,
      diagnosisTiming: json['diagnosisTiming'] as String?,
      gender: json['gender'] as String?,
      nickname: json['nickname'] as String?,
      bio: json['bio'] as String?,
      interestList: (json['interestList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MemberUpdateRequestToJson(
        MemberUpdateRequest instance) =>
    <String, dynamic>{
      'diseaseId': instance.diseaseId,
      'diagnosisTiming': instance.diagnosisTiming,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'bio': instance.bio,
      'interestList': instance.interestList,
    };
