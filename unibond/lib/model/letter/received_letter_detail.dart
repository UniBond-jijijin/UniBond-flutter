import 'package:json_annotation/json_annotation.dart';

part 'received_letter_detail.g.dart';

// 받은 편지 상세 내용 GET을 위한 모델
@JsonSerializable()
class ReceivedLetterDetail {
  final bool isSuccess;
  final int code;
  final String message;
  final ReceivedLetter result;

  ReceivedLetterDetail({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ReceivedLetterDetail.fromJson(Map<String, dynamic> json) =>
      _$ReceivedLetterDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivedLetterDetailToJson(this);
}

@JsonSerializable()
class ReceivedLetter {
  final String? arrivalDate;
  final bool? liked;
  final String? title;
  final String? content;

  ReceivedLetter({
    this.arrivalDate,
    this.liked,
    this.title,
    this.content,
  });

  factory ReceivedLetter.fromJson(Map<String, dynamic> json) =>
      _$ReceivedLetterFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivedLetterToJson(this);
}
