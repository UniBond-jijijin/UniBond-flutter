import 'package:get/get.dart';
import 'package:unibond/controller/dto/join_req_dto.dart';
import 'package:unibond/domain/user/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  Future<int> join(
    String userId,
    String password,
    String diseaseId,
    String diseaseTiming,
    String gender,
    String nickname,
    String bio,
    String interestList,
  ) async {
    JoinReqDto joinReqDto = JoinReqDto(userId, password, diseaseId,
        diseaseTiming, gender, nickname, bio, interestList);
    var userIdNum = await _userRepository.join(joinReqDto);
    return userIdNum;
  }

  // 테스트 서버용 로그인 메서드
  Future<String> login(String username, String password) async {
    String token = await _userRepository.login(username, password);

    // if (token != "-1") {
    //   jwtToken = token;
    // }

    return token;
  }
}
