import 'package:get/get.dart';

// 학교 IPv4 주소
const host = "http://192.168.56.1:8080";

// 우리꺼
// const host = "http://3.35.110.214";

class UserProvider extends GetConnect {
  // 임시
  Future<Response> login(Map data) => post("$host/login", data);
  // Future<Response> join(Map data) => post("$host/api/v1/members", data);
}
