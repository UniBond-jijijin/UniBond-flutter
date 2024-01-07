// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_letter_boxs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LetterBoxRequest _$LetterBoxRequestFromJson(Map<String, dynamic> json) =>
    LetterBoxRequest(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: LetterBoxResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LetterBoxRequestToJson(LetterBoxRequest instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

LetterBoxResult _$LetterBoxResultFromJson(Map<String, dynamic> json) =>
    LetterBoxResult(
      pageInfo:
          LetterBoxPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      letterRoomList: (json['letterRoomList'] as List<dynamic>?)
          ?.map((e) => LetterBox.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LetterBoxResultToJson(LetterBoxResult instance) =>
    <String, dynamic>{
      'pageInfo': instance.pageInfo,
      'letterRoomList': instance.letterRoomList,
    };

LetterBoxPageInfo _$LetterBoxPageInfoFromJson(Map<String, dynamic> json) =>
    LetterBoxPageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$LetterBoxPageInfoToJson(LetterBoxPageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
    };

LetterBox _$LetterBoxFromJson(Map<String, dynamic> json) => LetterBox(
      senderProfileImg: json['senderProfileImg'] as String,
      senderNick: json['senderNick'] as String,
      senderId: json['senderId'] as int,
      recentLetterSentDate: json['recentLetterSentDate'] as String,
      letterRoomId: json['letterRoomId'] as int,
    );

Map<String, dynamic> _$LetterBoxToJson(LetterBox instance) => <String, dynamic>{
      'senderProfileImg': instance.senderProfileImg,
      'senderNick': instance.senderNick,
      'senderId': instance.senderId,
      'recentLetterSentDate': instance.recentLetterSentDate,
      'letterRoomId': instance.letterRoomId,
    };
