import 'package:get/get.dart';
import 'package:unibond/util/userIdNum.dart';

const host = "http://3.35.110.214";

class PostProvider extends GetConnect {
  // Qna
  Future<Response> getQnaPostsList() => get("$host/api/v1/community/question",
      headers: {"Authorization": userIdNum ?? ""});

  Future<Response> uploadQnaPost(Map data) {
    print(data);

    return post(
        "$host/api/v1/community/question",
        headers: {"Authorization": "29"},
        data);
  }

  // 경험공유
  Future<Response> getExpPostsList() => get("$host/api/v1/community/experience",
      headers: {"Authorization": userIdNum ?? ""});
  Future<Response> uploadExpPost(Map data) {
    print(data);

    return post(
        "$host/api/v1/community/experience",
        headers: {"Authorization": "29"},
        data);
  }
}
