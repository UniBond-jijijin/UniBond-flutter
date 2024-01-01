// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result:
          UserProfileResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

UserProfileResult _$UserProfileResultFromJson(Map<String, dynamic> json) =>
    UserProfileResult(
      profileImage: json['profileImage'] as String,
      nickname: json['nickname'] as String,
      gender: json['gender'] as String,
      diseaseName: json['diseaseName'] as String,
      diagnosisTiming: json['diagnosisTiming'] as String,
      bio: json['bio'] as String,
      interestList: (json['interestList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserProfileResultToJson(UserProfileResult instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'diseaseName': instance.diseaseName,
      'diagnosisTiming': instance.diagnosisTiming,
      'bio': instance.bio,
      'interestList': instance.interestList,
    };
