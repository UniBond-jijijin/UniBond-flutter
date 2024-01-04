// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_receive_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreReceiveLetter _$PreReceiveLetterFromJson(Map<String, dynamic> json) =>
    PreReceiveLetter(
      sendDate: json['sendDate'] == null
          ? null
          : DateTime.parse(json['sendDate'] as String),
      liked: json['liked'] as bool?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$PreReceiveLetterToJson(PreReceiveLetter instance) =>
    <String, dynamic>{
      'sendDate': instance.sendDate?.toIso8601String(),
      'liked': instance.liked,
      'content': instance.content,
    };
