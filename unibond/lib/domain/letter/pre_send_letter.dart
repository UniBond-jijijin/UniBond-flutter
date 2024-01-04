import 'package:json_annotation/json_annotation.dart';

part 'pre_send_letter.g.dart';

@JsonSerializable()
class PreSendLetter {
  final DateTime? sendDate;
  final DateTime? arrivalDate;
  final String? content;

  PreSendLetter({
    this.sendDate,
    this.arrivalDate,
    this.content,
  });

  factory PreSendLetter.fromJson(Map<String, dynamic> json) =>
      _$PreSendLetterFromJson(json);

  Map<String, dynamic> toJson() => _$PreSendLetterToJson(this);
}
