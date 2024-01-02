// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberRegisterRequest _$MemberRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    MemberRegisterRequest(
      request: MemberRequest.fromJson(json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberRegisterRequestToJson(
        MemberRegisterRequest instance) =>
    <String, dynamic>{
      'request': instance.request,
    };
