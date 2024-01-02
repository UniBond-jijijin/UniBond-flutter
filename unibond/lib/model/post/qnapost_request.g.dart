// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qnapost_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QnaPostRequest _$QnaPostRequestFromJson(Map<String, dynamic> json) =>
    QnaPostRequest(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: QnaPostResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QnaPostRequestToJson(QnaPostRequest instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

QnaPostResult _$QnaPostResultFromJson(Map<String, dynamic> json) =>
    QnaPostResult(
      loginMemberProfileImage: json['loginMemberProfileImage'] as String,
      postOwnerId: json['postOwnerId'] as int,
      profileImage: json['profileImage'] as String,
      postOwnerName: json['postOwnerName'] as String,
      createdDate: json['createdDate'] as String,
      diseaseName: json['diseaseName'] as String,
      postImg: json['postImg'] as String,
      content: json['content'] as String,
      commentCount: json['commentCount'] as String,
      parentCommentPageInfo: ParentCommentPageInfo.fromJson(
          json['parentCommentPageInfo'] as Map<String, dynamic>),
      parentCommentList: (json['parentCommentList'] as List<dynamic>?)
          ?.map((e) => ParentComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QnaPostResultToJson(QnaPostResult instance) =>
    <String, dynamic>{
      'loginMemberProfileImage': instance.loginMemberProfileImage,
      'postOwnerId': instance.postOwnerId,
      'profileImage': instance.profileImage,
      'postOwnerName': instance.postOwnerName,
      'createdDate': instance.createdDate,
      'diseaseName': instance.diseaseName,
      'postImg': instance.postImg,
      'content': instance.content,
      'commentCount': instance.commentCount,
      'parentCommentPageInfo': instance.parentCommentPageInfo,
      'parentCommentList': instance.parentCommentList,
    };

ParentCommentPageInfo _$ParentCommentPageInfoFromJson(
        Map<String, dynamic> json) =>
    ParentCommentPageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$ParentCommentPageInfoToJson(
        ParentCommentPageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
    };

ParentComment _$ParentCommentFromJson(Map<String, dynamic> json) =>
    ParentComment(
      commentUserId: json['commentUserId'] as int,
      profileImgUrl: json['profileImgUrl'] as String,
      commentUserName: json['commentUserName'] as String,
      commentId: json['commentId'] as int,
      createdDate: json['createdDate'] as String,
      content: json['content'] as String,
      childCommentPageInfo: ChildCommentPageInfo.fromJson(
          json['childCommentPageInfo'] as Map<String, dynamic>),
      childCommentList: (json['childCommentList'] as List<dynamic>?)
          ?.map((e) => ChildComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentCommentToJson(ParentComment instance) =>
    <String, dynamic>{
      'commentUserId': instance.commentUserId,
      'profileImgUrl': instance.profileImgUrl,
      'commentUserName': instance.commentUserName,
      'commentId': instance.commentId,
      'createdDate': instance.createdDate,
      'content': instance.content,
      'childCommentPageInfo': instance.childCommentPageInfo,
      'childCommentList': instance.childCommentList,
    };

ChildCommentPageInfo _$ChildCommentPageInfoFromJson(
        Map<String, dynamic> json) =>
    ChildCommentPageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$ChildCommentPageInfoToJson(
        ChildCommentPageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
    };

ChildComment _$ChildCommentFromJson(Map<String, dynamic> json) => ChildComment(
      commentUserId: json['commentUserId'] as int,
      profileImgUrl: json['profileImgUrl'] as String,
      commentUserName: json['commentUserName'] as String,
      commentId: json['commentId'] as int,
      createdDate: json['createdDate'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChildCommentToJson(ChildComment instance) =>
    <String, dynamic>{
      'commentUserId': instance.commentUserId,
      'profileImgUrl': instance.profileImgUrl,
      'commentUserName': instance.commentUserName,
      'commentId': instance.commentId,
      'createdDate': instance.createdDate,
      'content': instance.content,
    };
