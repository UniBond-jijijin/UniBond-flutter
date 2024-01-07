// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_letter_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentLetterDetail _$SentLetterDetailFromJson(Map<String, dynamic> json) =>
    SentLetterDetail(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: SentLetter.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SentLetterDetailToJson(SentLetterDetail instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

SentLetter _$SentLetterFromJson(Map<String, dynamic> json) => SentLetter(
      sendDate: json['sendDate'] as String?,
      arrivalDate: json['arrivalDate'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$SentLetterToJson(SentLetter instance) =>
    <String, dynamic>{
      'sendDate': instance.sendDate,
      'arrivalDate': instance.arrivalDate,
      'content': instance.content,
    };
