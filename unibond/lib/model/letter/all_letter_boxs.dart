import 'package:json_annotation/json_annotation.dart';

part 'all_letter_boxs.g.dart';

// 참여중인 모든 편지함 목록 GET을 위한 모델
@JsonSerializable()
class LetterBoxRequest {
  final bool isSuccess;
  final int code;
  final String message;
  final LetterBoxResult result;

  LetterBoxRequest({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory LetterBoxRequest.fromJson(Map<String, dynamic> json) =>
      _$LetterBoxRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LetterBoxRequestToJson(this);
}

@JsonSerializable()
class LetterBoxResult {
  final LetterBoxPageInfo pageInfo;
  final List<LetterBox>? letterRoomList; // api 변수가 room이어서 예외적으로 room 용어 씀.

  LetterBoxResult({
    required this.pageInfo,
    this.letterRoomList,
  });

  factory LetterBoxResult.fromJson(Map<String, dynamic> json) =>
      _$LetterBoxResultFromJson(json);

  Map<String, dynamic> toJson() => _$LetterBoxResultToJson(this);
}

@JsonSerializable()
class LetterBoxPageInfo {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  LetterBoxPageInfo({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory LetterBoxPageInfo.fromJson(Map<String, dynamic> json) =>
      _$LetterBoxPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LetterBoxPageInfoToJson(this);
}

@JsonSerializable()
class LetterBox {
  final String senderProfileImg;
  final String senderNick;
  final int senderId;
  final String recentLetterSentDate;
  final int letterRoomId;

  LetterBox({
    required this.senderProfileImg,
    required this.senderNick,
    required this.senderId,
    required this.recentLetterSentDate,
    required this.letterRoomId,
  });

  factory LetterBox.fromJson(Map<String, dynamic> json) =>
      _$LetterBoxFromJson(json);

  Map<String, dynamic> toJson() => _$LetterBoxToJson(this);
}
