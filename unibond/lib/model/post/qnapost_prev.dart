import 'package:json_annotation/json_annotation.dart';

part 'qnapost_prev.g.dart';

// 질문게시판 미리보기(홈화면) 게시물 GET을 위한 모델
@JsonSerializable()
class QnaPostPrevRequest {
  final bool isSuccess;
  final int code;
  final String message;
  final QnaPostPrevResult result;

  QnaPostPrevRequest({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory QnaPostPrevRequest.fromJson(Map<String, dynamic> json) =>
      _$QnaPostPrevRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QnaPostPrevRequestToJson(this);
}

@JsonSerializable()
class QnaPostPrevResult {
  final QnaPostPrevPageInfo pageInfo;
  final List<String> postPreviewList;

  QnaPostPrevResult({
    required this.pageInfo,
    required this.postPreviewList,
  });

  factory QnaPostPrevResult.fromJson(Map<String, dynamic> json) =>
      _$QnaPostPrevResultFromJson(json);

  Map<String, dynamic> toJson() => _$QnaPostPrevResultToJson(this);
}

@JsonSerializable()
class QnaPostPrevPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;
  final List<PostPreview>? postPreviewList;

  QnaPostPrevPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.postPreviewList,
  });

  factory QnaPostPrevPageInfo.fromJson(Map<String, dynamic> json) =>
      _$QnaPostPrevPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$QnaPostPrevPageInfoToJson(this);
}

@JsonSerializable()
class PostPreview {
  final String createdDate;
  // API문서 변경된 부분
  final String ownerId;
  final String ownerProfileImg;
  final String ownerNick;
  final String disease;
  final String postId;
  final String? postImg;
  final String contentPreview;
  final String boardType;
  final bool isEnd;

  PostPreview({
    required this.createdDate,
    required this.ownerId,
    required this.ownerProfileImg,
    required this.ownerNick,
    required this.disease,
    required this.postId,
    this.postImg,
    required this.contentPreview,
    required this.boardType,
    required this.isEnd,
  });

  factory PostPreview.fromJson(Map<String, dynamic> json) =>
      _$PostPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$PostPreviewToJson(this);
}
