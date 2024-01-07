import 'package:json_annotation/json_annotation.dart';

part 'sent_letter_detail.g.dart';

// 보낸 편지 상세 내용 GET을 위한 모델
@JsonSerializable()
class SentLetterDetail {
  final bool isSuccess;
  final int code;
  final String message;
  final SentLetter result;

  SentLetterDetail({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory SentLetterDetail.fromJson(Map<String, dynamic> json) =>
      _$SentLetterDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SentLetterDetailToJson(this);
}

@JsonSerializable()
class SentLetter {
  final String? sendDate;
  final String? arrivalDate;
  final String? content;

  SentLetter({
    this.sendDate,
    this.arrivalDate,
    this.content,
  });

  factory SentLetter.fromJson(Map<String, dynamic> json) =>
      _$SentLetterFromJson(json);

  Map<String, dynamic> toJson() => _$SentLetterToJson(this);
}
