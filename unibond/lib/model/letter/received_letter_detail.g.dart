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
      arrivalDate: json['arrivalDate'] as String?,
      liked: json['liked'] as bool?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ReceivedLetterToJson(ReceivedLetter instance) =>
    <String, dynamic>{
      'arrivalDate': instance.arrivalDate,
      'liked': instance.liked,
      'title': instance.title,
      'content': instance.content,
    };
