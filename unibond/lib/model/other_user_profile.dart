import 'package:json_annotation/json_annotation.dart';

part 'other_user_profile.g.dart';

// 남의 프로필 GET을 위한 모델
@JsonSerializable()
class OtherUserProfile {
  final bool isSuccess;
  final int code;
  final String message;
  final OtherUserProfileResult result;

  OtherUserProfile({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory OtherUserProfile.fromJson(Map<String, dynamic> json) =>
      _$OtherUserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserProfileToJson(this);
}

@JsonSerializable()
class OtherUserProfileResult {
  final String profileImage;
  final String nickname;
  final String gender;
  final String diseaseName;
  final String diagnosisTiming;
  final String bio;
  final List<String>? interestList;
  final OtherUserProfilePageInfo? otherUserProfilePageInfo;
  final List<PostPreview>? postPreviewList;

  OtherUserProfileResult({
    required this.profileImage,
    required this.nickname,
    required this.gender,
    required this.diseaseName,
    required this.diagnosisTiming,
    required this.bio,
    this.interestList,
    this.otherUserProfilePageInfo,
    this.postPreviewList,
  });

  factory OtherUserProfileResult.fromJson(Map<String, dynamic> json) =>
      _$OtherUserProfileResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserProfileResultToJson(this);
}

@JsonSerializable()
class OtherUserProfilePageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  OtherUserProfilePageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory OtherUserProfilePageInfo.fromJson(Map<String, dynamic> json) =>
      _$OtherUserProfilePageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserProfilePageInfoToJson(this);
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
