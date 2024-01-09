import 'package:get/get.dart';
import 'package:unibond/util/auth_storage.dart';

const host = "http://3.35.110.214";

class PostProvider extends GetConnect {
  // Qna
  Future<Response> getQnaPostsList() async {
    String? authToken = await AuthStorage.getAuthToken();

    return get("$host/api/v1/community/question",
        headers: {"Authorization": authToken!});
  }

  Future<Response> uploadQnaPost(Map data) async {
    String? authToken = await AuthStorage.getAuthToken();

    return post(
        "$host/api/v1/community/question",
        headers: {"Authorization": authToken!},
        data);
  }

  // 경험공유
  Future<Response> getExpPostsList() async {
    String? authToken = await AuthStorage.getAuthToken();

    return get("$host/api/v1/community/experience",
        headers: {"Authorization": authToken!});
  }

  Future<Response> uploadExpPost(Map data) async {
    String? authToken = await AuthStorage.getAuthToken();

    return post(
        "$host/api/v1/community/experience",
        headers: {"Authorization": authToken!},
        data);
  }
}
