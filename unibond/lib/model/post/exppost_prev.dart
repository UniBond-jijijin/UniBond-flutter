import 'package:json_annotation/json_annotation.dart';

part 'exppost_prev.g.dart';

// 경험 공유 게시판 미리보기(홈화면) 게시물 GET을 위한 모델
@JsonSerializable()
class ExpPostPrevRequest {
  final bool isSuccess;
  final int code;
  final String message;
  final ExpPostPrevResult result;

  ExpPostPrevRequest({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ExpPostPrevRequest.fromJson(Map<String, dynamic> json) =>
      _$ExpPostPrevRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExpPostPrevRequestToJson(this);
}

@JsonSerializable()
class ExpPostPrevResult {
  final ExpPostPrevPageInfo pageInfo;
  final List<String> postPreviewList;

  ExpPostPrevResult({
    required this.pageInfo,
    required this.postPreviewList,
  });

  factory ExpPostPrevResult.fromJson(Map<String, dynamic> json) =>
      _$ExpPostPrevResultFromJson(json);

  Map<String, dynamic> toJson() => _$ExpPostPrevResultToJson(this);
}

@JsonSerializable()
class ExpPostPrevPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;
  final List<PostPreview>? postPreviewList;

  ExpPostPrevPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.postPreviewList,
  });

  factory ExpPostPrevPageInfo.fromJson(Map<String, dynamic> json) =>
      _$ExpPostPrevPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpPostPrevPageInfoToJson(this);
}

@JsonSerializable()
class PostPreview {
  final String createdDate;
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
