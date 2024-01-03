// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentPost _$CommentPostFromJson(Map<String, dynamic> json) => CommentPost(
      content: json['content'] as String,
      parentCommentId: json['parentCommentId'] as int?,
    );

Map<String, dynamic> _$CommentPostToJson(CommentPost instance) =>
    <String, dynamic>{
      'content': instance.content,
      'parentCommentId': instance.parentCommentId,
    };
