import 'package:json_annotation/json_annotation.dart';

part 'qnapost_request.g.dart';

// 질문게시판 상세 게시물 GET을 위한 모델
@JsonSerializable()
class QnaPostRequest {
  final bool isSuccess;
  final int code;
  final String message;
  final QnaPostResult result;

  QnaPostRequest({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory QnaPostRequest.fromJson(Map<String, dynamic> json) =>
      _$QnaPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QnaPostRequestToJson(this);
}

@JsonSerializable()
class QnaPostResult {
  final String loginMemberProfileImage;
  final int postOwnerId;
  final String profileImage;
  final String postOwnerName;
  final String createdDate;
  final String diseaseName;
  final String postImg;
  final String content;
  final String commentCount;
  final ParentCommentPageInfo parentCommentPageInfo;
  final List<ParentComment>? parentCommentList;

  QnaPostResult({
    required this.loginMemberProfileImage,
    required this.postOwnerId,
    required this.profileImage,
    required this.postOwnerName,
    required this.createdDate,
    required this.diseaseName,
    required this.postImg,
    required this.content,
    required this.commentCount,
    required this.parentCommentPageInfo,
    this.parentCommentList,
  });

  factory QnaPostResult.fromJson(Map<String, dynamic> json) =>
      _$QnaPostResultFromJson(json);

  Map<String, dynamic> toJson() => _$QnaPostResultToJson(this);
}

@JsonSerializable()
class ParentCommentPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  ParentCommentPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory ParentCommentPageInfo.fromJson(Map<String, dynamic> json) =>
      _$ParentCommentPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCommentPageInfoToJson(this);
}

@JsonSerializable()
class ParentComment {
  final int commentUserId;
  final String profileImgUrl;
  final String commentUserName;
  final int commentId;
  final String createdDate;
  final String content;
  final ChildCommentPageInfo childCommentPageInfo;
  final List<ChildComment>? childCommentList;

  ParentComment({
    required this.commentUserId,
    required this.profileImgUrl,
    required this.commentUserName,
    required this.commentId,
    required this.createdDate,
    required this.content,
    required this.childCommentPageInfo,
    this.childCommentList,
  });

  factory ParentComment.fromJson(Map<String, dynamic> json) =>
      _$ParentCommentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCommentToJson(this);
}

@JsonSerializable()
class ChildCommentPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  ChildCommentPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory ChildCommentPageInfo.fromJson(Map<String, dynamic> json) =>
      _$ChildCommentPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCommentPageInfoToJson(this);
}

@JsonSerializable()
class ChildComment {
  final int commentUserId;
  final String profileImgUrl;
  final String commentUserName;
  final int commentId;
  final String createdDate;
  final String content;

  ChildComment({
    required this.commentUserId,
    required this.profileImgUrl,
    required this.commentUserName,
    required this.commentId,
    required this.createdDate,
    required this.content,
  });

  factory ChildComment.fromJson(Map<String, dynamic> json) =>
      _$ChildCommentFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCommentToJson(this);
}
