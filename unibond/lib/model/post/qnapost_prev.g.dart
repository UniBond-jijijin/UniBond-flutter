// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qnapost_prev.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QnaPostPrevRequest _$QnaPostPrevRequestFromJson(Map<String, dynamic> json) =>
    QnaPostPrevRequest(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result:
          QnaPostPrevResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QnaPostPrevRequestToJson(QnaPostPrevRequest instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

QnaPostPrevResult _$QnaPostPrevResultFromJson(Map<String, dynamic> json) =>
    QnaPostPrevResult(
      pageInfo: QnaPostPrevPageInfo.fromJson(
          json['pageInfo'] as Map<String, dynamic>),
      postPreviewList: (json['postPreviewList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$QnaPostPrevResultToJson(QnaPostPrevResult instance) =>
    <String, dynamic>{
      'pageInfo': instance.pageInfo,
      'postPreviewList': instance.postPreviewList,
    };

QnaPostPrevPageInfo _$QnaPostPrevPageInfoFromJson(Map<String, dynamic> json) =>
    QnaPostPrevPageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
      postPreviewList: (json['postPreviewList'] as List<dynamic>?)
          ?.map((e) => PostPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QnaPostPrevPageInfoToJson(
        QnaPostPrevPageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'postPreviewList': instance.postPreviewList,
    };

PostPreview _$PostPreviewFromJson(Map<String, dynamic> json) => PostPreview(
      createdDate: json['createdDate'] as String,
      ownerId: json['ownerId'] as String,
      ownerProfileImg: json['ownerProfileImg'] as String,
      ownerNick: json['ownerNick'] as String,
      disease: json['disease'] as String,
      postId: json['postId'] as String,
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
