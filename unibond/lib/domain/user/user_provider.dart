import 'package:get/get.dart';

// 학교 IPv4 주소
// TODO: 배포된 주소로 변경
const host = "192.168.56.1:8080";

class UserProvider extends GetConnect {
  // api문서 미반영된 임시 경로
  Future<Response> login(Map data) => post("$host/login", data);
}
