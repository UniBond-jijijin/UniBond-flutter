class Letter {
  final int? id;
  final int? receiverId;
  final String? title;
  final String? content;

  Letter({
    this.id,
    this.receiverId,
    this.title,
    this.content,
  });

  Letter.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        receiverId = json["receiverId"],
        title = json["title"],
        content = json["content"];
}
