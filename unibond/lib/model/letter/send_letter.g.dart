// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LetterPostRequest _$LetterPostRequestFromJson(Map<String, dynamic> json) =>
    LetterPostRequest(
      receiverId: json['receiverId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$LetterPostRequestToJson(LetterPostRequest instance) =>
    <String, dynamic>{
      'receiverId': instance.receiverId,
      'title': instance.title,
      'content': instance.content,
    };

LetterPostResult _$LetterPostResultFromJson(Map<String, dynamic> json) =>
    LetterPostResult(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: json['result'] == null
          ? null
          : ArrivalTime.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LetterPostResultToJson(LetterPostResult instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

ArrivalTime _$ArrivalTimeFromJson(Map<String, dynamic> json) => ArrivalTime(
      arrivalTime: json['arrivalTime'] as String,
    );

Map<String, dynamic> _$ArrivalTimeToJson(ArrivalTime instance) =>
    <String, dynamic>{
      'arrivalTime': instance.arrivalTime,
    };
