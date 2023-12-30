class LetterReqDto {
  int? receiverId;
  String content;
  String title;

  LetterReqDto({
    required this.receiverId,
    required this.content,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'content': content,
        'title': title,
      };
}
