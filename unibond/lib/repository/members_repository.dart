import 'package:dio/dio.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/model/member_request.dart';
import 'package:unibond/model/member_update_request.dart';
import 'package:unibond/model/other_user_profile.dart';
import 'package:unibond/model/post/withdraw_dto.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/util/auth_storage.dart';

// 나의 프로필 조회
Future<UserProfile> getMyProfile(String memberId) async {
  final dio = Dio();

  // 저장된 인증 키 추출
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/$memberId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return UserProfile.fromJson(response.data);
}

// 남의 프로필 조회
Future<OtherUserProfile> getOtherProfile(String memberId) async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/$memberId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return OtherUserProfile.fromJson(response.data);
}

/// 프로필 수정
Future<CodeMsgResDto> updateMember(
    String memberId, MemberUpdateRequest updateRequest) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.patch(
    'http://3.35.110.214/api/v1/members/$memberId',
    data: updateRequest.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgResDto.fromJson(response.data);
}

/// 닉네임 중복 검사
Future<CodeMsgResDto> checkNicknameDuplicate(String nickname) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/duplicate',
    queryParameters: {'nickname': nickname},
  );
  return CodeMsgResDto.fromJson(response.data);
}

/// 회원가입
Future<CodeMsgResDto> createMember(MemberRequest createRequest) async {
  final dio = Dio();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/members',
    data: createRequest.toJson(),
  );
  return CodeMsgResDto.fromJson(response.data);
}

// 회원탈퇴
class WithdrawRepository {
  final Dio _dio = Dio();

  Future<WithdrawDto> withdrawUser(String userId) async {
    try {
      final response = await _dio.delete(
        'http://3.35.110.214/api/v1/members',
        options: Options(headers: {'Authorization': userId}),
      );

      return WithdrawDto.fromJson(response.data);
    } catch (error) {
      throw Exception('Error withdraw: $error');
    }
  }
}
