class PostUploadReqDto {
  final String? content;

  PostUploadReqDto(this.content);

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}
