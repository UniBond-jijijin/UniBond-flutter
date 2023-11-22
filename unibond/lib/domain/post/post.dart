import 'package:unibond/domain/user/user.dart';

class Post {
  final int? id;
  final String? title;
  final String? content;
  final User? user;

  Post({
    this.id,
    this.title,
    this.content,
    this.user,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        user = User.fromJson(json["user"]);
}
