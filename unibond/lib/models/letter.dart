class Letter {
  final String title;
  final String content;
  bool isBookmarked;

  Letter({
    required this.title,
    required this.content,
    this.isBookmarked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title.trim(),
      'content': content.trim(),
      'isBookmarked': isBookmarked,
    };
  }
}
