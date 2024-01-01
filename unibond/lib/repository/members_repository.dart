import 'package:dio/dio.dart';
import 'package:unibond/model/user_profile.dart';

Future<UserProfile> getMyProfile(String memberId) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/members/$memberId',
    options: Options(headers: {'Authorization': memberId}),
  );
  return UserProfile.fromJson(response.data);
}
