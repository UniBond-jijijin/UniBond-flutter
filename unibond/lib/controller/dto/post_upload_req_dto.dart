class QnAPostUploadReqDto {
  final String? content;

  QnAPostUploadReqDto(this.content);

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}

class ExpPostUploadReqDto {
  final String? content;

  ExpPostUploadReqDto(this.content);

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}
