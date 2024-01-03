import 'package:get/get.dart';
import 'package:unibond/util/userIdNum.dart';

const host = "http://3.35.110.214";

class PostProvider extends GetConnect {
  // TODO: question, experience 메서드 따로 만들기
  // 게시물 미리보기 조회
  Future<Response> getQnaPostsList() => get("$host/api/v1/community/question",
      headers: {"Authorization": userIdNum ?? ""});

  // 게시물 등록
  Future<Response> uploadPost(Map data) {
    print(data);

    return post(
        "$host/api/v1/community/question",
        headers: {"Authorization": "29"},
        data);
  }
}
