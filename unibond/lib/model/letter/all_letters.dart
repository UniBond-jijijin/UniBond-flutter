import 'package:json_annotation/json_annotation.dart';

part 'all_letters.g.dart';

// 참여중인 편지함의 편지 목록 GET을 위한 모델
@JsonSerializable()
class AllLettersRequest {
  final bool isSuccess;
  final int code;
  final String message;
  final AllLettersResult result;

  AllLettersRequest({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory AllLettersRequest.fromJson(Map<String, dynamic> json) =>
      _$AllLettersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AllLettersRequestToJson(this);
}

@JsonSerializable()
class AllLettersResult {
  final int loginId;
  final int receiverId;
  final String receiverProfileImg;
  final String receiverName;
  final String receiverDiseaseName;
  final String receiverDiagnosisTiming;
  final AllLettersPageInfo pageInfo;
  final List<AllLetters> letterList;

  AllLettersResult({
    required this.loginId,
    required this.receiverId,
    required this.receiverProfileImg,
    required this.receiverName,
    required this.receiverDiseaseName,
    required this.receiverDiagnosisTiming,
    required this.pageInfo,
    required this.letterList,
  });

  factory AllLettersResult.fromJson(Map<String, dynamic> json) =>
      _$AllLettersResultFromJson(json);

  Map<String, dynamic> toJson() => _$AllLettersResultToJson(this);
}

@JsonSerializable()
class AllLettersPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  AllLettersPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory AllLettersPageInfo.fromJson(Map<String, dynamic> json) =>
      _$AllLettersPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AllLettersPageInfoToJson(this);
}

@JsonSerializable()
class AllLetters {
  final int letterId;
  final int senderId;
  final String senderName;
  final String sentDate;
  final String letterTitle;

  AllLetters({
    required this.letterId,
    required this.senderId,
    required this.senderName,
    required this.sentDate,
    required this.letterTitle,
  });

  factory AllLetters.fromJson(Map<String, dynamic> json) =>
      _$AllLettersFromJson(json);

  Map<String, dynamic> toJson() => _$AllLettersToJson(this);
}
