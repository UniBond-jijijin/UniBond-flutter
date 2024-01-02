// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberRequest _$MemberRequestFromJson(Map<String, dynamic> json) =>
    MemberRequest(
      diseaseId: json['diseaseId'] as int,
      diseaseTiming: json['diseaseTiming'] as String,
      nickname: json['nickname'] as String,
      gender: json['gender'] as String,
      bio: json['bio'] as String,
      interestList: (json['interestList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MemberRequestToJson(MemberRequest instance) =>
    <String, dynamic>{
      'diseaseId': instance.diseaseId,
      'diseaseTiming': instance.diseaseTiming,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'bio': instance.bio,
      'interestList': instance.interestList,
    };
