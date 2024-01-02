class LetterReqDto {
  String receiverId;
  String content;
  String title;

  LetterReqDto({
    required this.receiverId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'title': title,
        'content': content,
      };
}
