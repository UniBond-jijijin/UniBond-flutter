import 'package:json_annotation/json_annotation.dart';

part 'comment_post.g.dart';

// 게시물 댓글 POST를 위한 모델
@JsonSerializable()
class CommentPost {
  final String content;
  final int? parentCommentId;

  CommentPost({
    required this.content,
    this.parentCommentId,
  });

  factory CommentPost.fromJson(Map<String, dynamic> json) =>
      _$CommentPostFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPostToJson(this);
}
