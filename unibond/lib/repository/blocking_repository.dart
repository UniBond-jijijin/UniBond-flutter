import 'package:dio/dio.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/model/block_model.dart';
import 'package:unibond/util/auth_storage.dart';

/// 사용자 차단
Future<CodeMsgDto> blockUser(BlockingUser blockingUser) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/blocks/member',
    data: blockingUser.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgDto.fromJson(response.data);
}

/// 게시글 차단
Future<CodeMsgDto> blockPost(BlockingPost blockingPost) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/blocks/post',
    data: blockingPost.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgDto.fromJson(response.data);
}

/// 댓글 차단
Future<CodeMsgDto> blockComment(BlockingComment blockingComment) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/blocks/comment',
    data: blockingComment.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgDto.fromJson(response.data);
}

/// 편지 차단
Future<CodeMsgDto> blockLetter(BlockingLetter blockingLetter) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/blocks/letter',
    data: blockingLetter.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgDto.fromJson(response.data);
}

/// 편지리스트 차단
Future<CodeMsgDto> blockLetterList(
    BlockingLetterList blockingLetterList) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  dio.interceptors.add(LogInterceptor(
    responseBody: true,
  ));

  final response = await dio.post(
    'http://3.35.110.214/api/v1/blocks/letter-room',
    data: blockingLetterList.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );

  return CodeMsgDto.fromJson(response.data);
}
