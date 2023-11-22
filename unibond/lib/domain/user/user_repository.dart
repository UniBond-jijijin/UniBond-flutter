import 'package:get/get.dart';
import 'package:unibond/controller/dto/login_req_dto.dart';
import 'package:unibond/domain/user/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<void> login(String username, String password) async {
    // username, password를 map으로 바꿔서 input필요
    LoginReqDto loginReqDto = LoginReqDto(username, password);
    Response response = await _userProvider.login(loginReqDto.toJson());
    print(response);
    print(response.body);
  }
}
