// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserProfile _$OtherUserProfileFromJson(Map<String, dynamic> json) =>
    OtherUserProfile(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: OtherUserProfileResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtherUserProfileToJson(OtherUserProfile instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

OtherUserProfileResult _$OtherUserProfileResultFromJson(
        Map<String, dynamic> json) =>
    OtherUserProfileResult(
      profileImage: json['profileImage'] as String,
      nickname: json['nickname'] as String,
      gender: json['gender'] as String,
      diseaseName: json['diseaseName'] as String,
      diagnosisTiming: json['diagnosisTiming'] as String,
      bio: json['bio'] as String,
      interestList: (json['interestList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      otherUserProfilePageInfo: json['otherUserProfilePageInfo'] == null
          ? null
          : OtherUserProfilePageInfo.fromJson(
              json['otherUserProfilePageInfo'] as Map<String, dynamic>),
      postPreviewList: (json['postPreviewList'] as List<dynamic>?)
          ?.map((e) => PostPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OtherUserProfileResultToJson(
        OtherUserProfileResult instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'diseaseName': instance.diseaseName,
      'diagnosisTiming': instance.diagnosisTiming,
      'bio': instance.bio,
      'interestList': instance.interestList,
      'otherUserProfilePageInfo': instance.otherUserProfilePageInfo,
      'postPreviewList': instance.postPreviewList,
    };

OtherUserProfilePageInfo _$OtherUserProfilePageInfoFromJson(
        Map<String, dynamic> json) =>
    OtherUserProfilePageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$OtherUserProfilePageInfoToJson(
        OtherUserProfilePageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
    };

PostPreview _$PostPreviewFromJson(Map<String, dynamic> json) => PostPreview(
      createdDate: json['createdDate'] as String,
      ownerId: json['ownerId'] as int,
      ownerProfileImg: json['ownerProfileImg'] as String,
      ownerNick: json['ownerNick'] as String,
      disease: json['disease'] as String,
      postId: json['postId'] as int,
      postImg: json['postImg'] as String?,
      contentPreview: json['contentPreview'] as String,
      boardType: json['boardType'] as String,
      isEnd: json['isEnd'] as bool,
    );

Map<String, dynamic> _$PostPreviewToJson(PostPreview instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'ownerId': instance.ownerId,
      'ownerProfileImg': instance.ownerProfileImg,
      'ownerNick': instance.ownerNick,
      'disease': instance.disease,
      'postId': instance.postId,
      'postImg': instance.postImg,
      'contentPreview': instance.contentPreview,
      'boardType': instance.boardType,
      'isEnd': instance.isEnd,
    };
