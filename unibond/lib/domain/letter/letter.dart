class Letter {
  final int? id;
  final int? receiverId;
  final String title;
  bool? isliked;
  final String content;

  Letter({
    this.id,
    this.receiverId,
    required this.title,
    this.isliked,
    required this.content,
  });

  Letter.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        receiverId = json["receiverId"],
        title = json["title"],
        isliked = json["liked"],
        content = json["content"];
}
