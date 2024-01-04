// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_send_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreSendLetter _$PreSendLetterFromJson(Map<String, dynamic> json) =>
    PreSendLetter(
      sendDate: json['sendDate'] == null
          ? null
          : DateTime.parse(json['sendDate'] as String),
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$PreSendLetterToJson(PreSendLetter instance) =>
    <String, dynamic>{
      'sendDate': instance.sendDate?.toIso8601String(),
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'content': instance.content,
    };
