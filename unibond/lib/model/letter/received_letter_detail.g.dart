// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_letter_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivedLetterDetail _$ReceivedLetterDetailFromJson(
        Map<String, dynamic> json) =>
    ReceivedLetterDetail(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: ReceivedLetter.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceivedLetterDetailToJson(
        ReceivedLetterDetail instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

ReceivedLetter _$ReceivedLetterFromJson(Map<String, dynamic> json) =>
    ReceivedLetter(
      sendDate: json['sendDate'] as String?,
      liked: json['liked'] as bool?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ReceivedLetterToJson(ReceivedLetter instance) =>
    <String, dynamic>{
      'sendDate': instance.sendDate,
      'liked': instance.liked,
      'content': instance.content,
    };
