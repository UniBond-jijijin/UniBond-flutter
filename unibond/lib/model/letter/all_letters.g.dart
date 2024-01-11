// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_letters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLettersRequest _$AllLettersRequestFromJson(Map<String, dynamic> json) =>
    AllLettersRequest(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: AllLettersResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllLettersRequestToJson(AllLettersRequest instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

AllLettersResult _$AllLettersResultFromJson(Map<String, dynamic> json) =>
    AllLettersResult(
      loginId: json['loginId'] as int,
      receiverId: json['receiverId'] as int,
      receiverProfileImg: json['receiverProfileImg'] as String,
      receiverName: json['receiverName'] as String,
      receiverDiseaseName: json['receiverDiseaseName'] as String,
      receiverDiagnosisTiming: json['receiverDiagnosisTiming'] as String,
      pageInfo:
          AllLettersPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      letterList: (json['letterList'] as List<dynamic>)
          .map((e) => AllLetters.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllLettersResultToJson(AllLettersResult instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'receiverId': instance.receiverId,
      'receiverProfileImg': instance.receiverProfileImg,
      'receiverName': instance.receiverName,
      'receiverDiseaseName': instance.receiverDiseaseName,
      'receiverDiagnosisTiming': instance.receiverDiagnosisTiming,
      'pageInfo': instance.pageInfo,
      'letterList': instance.letterList,
    };

AllLettersPageInfo _$AllLettersPageInfoFromJson(Map<String, dynamic> json) =>
    AllLettersPageInfo(
      numberOfElements: json['numberOfElements'] as int,
      lastPage: json['lastPage'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$AllLettersPageInfoToJson(AllLettersPageInfo instance) =>
    <String, dynamic>{
      'numberOfElements': instance.numberOfElements,
      'lastPage': instance.lastPage,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
    };

AllLetters _$AllLettersFromJson(Map<String, dynamic> json) => AllLetters(
      letterId: json['letterId'] as int,
      senderId: json['senderId'] as int,
      senderName: json['senderName'] as String,
      sentDate: json['sentDate'] as String,
      letterTitle: json['letterTitle'] as String,
    );

Map<String, dynamic> _$AllLettersToJson(AllLetters instance) =>
    <String, dynamic>{
      'letterId': instance.letterId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'sentDate': instance.sentDate,
      'letterTitle': instance.letterTitle,
    };
