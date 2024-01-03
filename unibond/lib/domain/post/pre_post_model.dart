import 'package:intl/intl.dart';

class PrevPost {
  final DateTime? createdDate;
  final String? ownerProfileImg;
  final String? ownerNick;
  final String? disease;
  final String? contentPreview;
  final String? boardType;
  final bool? isEnd;
  final String postId;

  PrevPost({
    this.createdDate,
    this.ownerProfileImg,
    this.ownerNick,
    this.disease,
    this.contentPreview,
    this.boardType,
    this.isEnd,
    required this.postId,
  });

  PrevPost.fromJson(Map<String, dynamic> json)
      : createdDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(json["createdDate"]),
        ownerProfileImg = json["ownerProfileImg"],
        ownerNick = json["ownerNick"],
        disease = json["disease"],
        contentPreview = json["contentPreview"],
        boardType = json["boardType"],
        isEnd = json["isEnd"],
        postId = json["postId"].toString();
}
