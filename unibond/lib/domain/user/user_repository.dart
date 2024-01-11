import 'package:get/get.dart';
import 'package:unibond/controller/dto/join_req_dto.dart';
import 'package:unibond/controller/dto/login_req_dto.dart';
import 'package:unibond/domain/user/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<int> join(JoinReqDto joinReqDto) async {
    try {
      Response response = await _userProvider.join(joinReqDto.toJson());
      int userIdNum = response.body["result"];

      if (response.body["isSuccess"] == false) {
        throw Exception("Failed to send user data");
      } else {
        return userIdNum;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> login(String username, String password) async {
    // provider의 login함수에 username, password를 map으로 바꿔서 넣기 위한 dto 생성
    LoginReqDto loginReqDto = LoginReqDto(username, password);
    Response response = await _userProvider.login(loginReqDto.toJson());
    dynamic headers = response.headers;

    if (headers['authorization'] == null) {
      return "-1";
    } else {
      String token = headers['authorization'];
      return token;
    }
  }
}
