import 'package:get/get.dart';
import 'package:unibond/util/userIdNum.dart';

const host = "http://3.35.110.214";

class PostProvider extends GetConnect {
  Future<Response> getPostsList() => get("$host/api/v1/community/experience",
      headers: {"Authorization": userIdNum ?? ""});
}
