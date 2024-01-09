// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockingUser _$BlockingUserFromJson(Map<String, dynamic> json) => BlockingUser(
      blockedMemberId: json['blockedMemberId'] as int,
    );

Map<String, dynamic> _$BlockingUserToJson(BlockingUser instance) =>
    <String, dynamic>{
      'blockedMemberId': instance.blockedMemberId,
    };

BlockingPost _$BlockingPostFromJson(Map<String, dynamic> json) => BlockingPost(
      blockedPostId: json['blockedPostId'] as int,
    );

Map<String, dynamic> _$BlockingPostToJson(BlockingPost instance) =>
    <String, dynamic>{
      'blockedPostId': instance.blockedPostId,
    };

BlockingComment _$BlockingCommentFromJson(Map<String, dynamic> json) =>
    BlockingComment(
      blockedCommentId: json['blockedCommentId'] as int,
    );

Map<String, dynamic> _$BlockingCommentToJson(BlockingComment instance) =>
    <String, dynamic>{
      'blockedCommentId': instance.blockedCommentId,
    };
