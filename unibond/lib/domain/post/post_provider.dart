import 'package:get/get.dart';
import 'package:unibond/util/userIdNum.dart';

const host = "http://3.35.110.214";

class PostProvider extends GetConnect {
  // TODO: question, experience 메서드 따로 만들기
  Future<Response> getPostsList() => get("$host/api/v1/community/question",
      headers: {"Authorization": userIdNum ?? ""});
  Future<Response> uploadPost(Map data) {
    print(data);

    return post(
        "$host/api/v1/community/question",
        headers: {"Authorization": "4"},
        data);
  }
}
