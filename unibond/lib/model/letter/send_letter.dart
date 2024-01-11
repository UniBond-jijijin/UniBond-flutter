import 'package:json_annotation/json_annotation.dart';

part 'send_letter.g.dart';

// 편지 전송 POST를 위한 모델
@JsonSerializable()
class LetterPostRequest {
  final String receiverId;
  final String title;
  final String content;

  LetterPostRequest({
    required this.receiverId,
    required this.title,
    required this.content,
  });

  factory LetterPostRequest.fromJson(Map<String, dynamic> json) =>
      _$LetterPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LetterPostRequestToJson(this);
}

@JsonSerializable()
class LetterPostResult {
  final bool isSuccess;
  final int code;
  final String message;
  final ArrivalTime? result;

  LetterPostResult({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory LetterPostResult.fromJson(Map<String, dynamic> json) =>
      _$LetterPostResultFromJson(json);

  Map<String, dynamic> toJson() => _$LetterPostResultToJson(this);
}

@JsonSerializable()
class ArrivalTime {
  final String arrivalTime;

  ArrivalTime({
    required this.arrivalTime,
  });

  factory ArrivalTime.fromJson(Map<String, dynamic> json) =>
      _$ArrivalTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ArrivalTimeToJson(this);
}
