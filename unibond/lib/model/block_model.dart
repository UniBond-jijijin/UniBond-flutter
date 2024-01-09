import 'package:json_annotation/json_annotation.dart';

part 'block_model.g.dart';

// 사용자 차단 POST를 위한 모델
@JsonSerializable()
class BlockingUser {
  final int blockedMemberId;

  BlockingUser({
    required this.blockedMemberId,
  });

  factory BlockingUser.fromJson(Map<String, dynamic> json) =>
      _$BlockingUserFromJson(json);

  Map<String, dynamic> toJson() => _$BlockingUserToJson(this);
}

// 게시글 차단 POST를 위한 모델
@JsonSerializable()
class BlockingPost {
  final int blockedPostId;

  BlockingPost({
    required this.blockedPostId,
  });

  factory BlockingPost.fromJson(Map<String, dynamic> json) =>
      _$BlockingPostFromJson(json);

  Map<String, dynamic> toJson() => _$BlockingPostToJson(this);
}

// 댓글 차단 POST를 위한 모델
@JsonSerializable()
class BlockingComment {
  final int blockedCommentId;

  BlockingComment({
    required this.blockedCommentId,
  });

  factory BlockingComment.fromJson(Map<String, dynamic> json) =>
      _$BlockingCommentFromJson(json);

  Map<String, dynamic> toJson() => _$BlockingCommentToJson(this);
}
