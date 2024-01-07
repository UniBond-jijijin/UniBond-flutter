import 'package:json_annotation/json_annotation.dart';

part 'pre_receive_letter.g.dart';

@JsonSerializable()
class PreReceiveLetter {
  final DateTime? sendDate;
  final bool? liked;
  final String? content;

  PreReceiveLetter({
    this.sendDate,
    this.liked,
    this.content,
  });

  factory PreReceiveLetter.fromJson(Map<String, dynamic> json) =>
      _$PreReceiveLetterFromJson(json);

  Map<String, dynamic> toJson() => _$PreReceiveLetterToJson(this);
}
