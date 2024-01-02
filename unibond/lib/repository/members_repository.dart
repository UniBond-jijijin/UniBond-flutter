import 'package:dio/dio.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/model/member_update_request.dart';
import 'package:unibond/model/other_user_profile.dart';
import 'package:unibond/model/user_profile.dart';

// 나의 프로필 조회
Future<UserProfile> getMyProfile(String memberId) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/$memberId',
    options: Options(headers: {'Authorization': memberId}),
  );
  return UserProfile.fromJson(response.data);
}

// 남의 프로필 조회
Future<OtherUserProfile> getOtherProfile(String memberId) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/$memberId',
    options: Options(headers: {'Authorization': memberId}),
  );
  print(response);
  print(OtherUserProfile.fromJson(response.data));
  print(response.data);
  print(response);

  return OtherUserProfile.fromJson(response.data);
}

/// 프로필 수정
Future<CodeMsgResDto> updateMember(
    String memberId, MemberUpdateRequest updateRequest) async {
  final dio = Dio();
  final response = await dio.patch(
    'http://3.35.110.214/api/v1/members/$memberId',
    data: updateRequest.toJson(),
    options: Options(headers: {'Authorization': '3'}),
  );
  return CodeMsgResDto.fromJson(response.data);
}

/// 닉네임 중복 검사
Future<CodeMsgResDto> checkNicknameDuplicate(String nickname) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/duplicate',
    options: Options(headers: {'Authorization': '3'}),
    queryParameters: {'nickname': nickname},
  );
  return CodeMsgResDto.fromJson(response.data);
}
