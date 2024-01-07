import 'package:dio/dio.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/model/post/comment_post.dart';
import 'package:unibond/model/post/exppost_prev.dart';
import 'package:unibond/model/post/qnapost_request.dart';
import 'package:unibond/util/auth_storage.dart';

// 상세 게시물 조회
Future<QnaPostDetail> getQnaPostDetail(String postId) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/community/$postId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return QnaPostDetail.fromJson(response.data);
}

/// 댓글 작성 POST
Future<CodeMsgDto> postComment(String postId, CommentPost commentPost) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/community/$postId/comments',
    data: commentPost.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );
  return CodeMsgDto.fromJson(response.data);
}

/// 경험 공유 미리보기 게시물 조회
Future<ExpPostPrevRequest> getExpPostsList() async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  dio.interceptors.add(LogInterceptor(
    responseBody: true, // 응답 본문을 찍을지 여부
  ));
  final response = await dio.get(
    'http://3.35.110.214/api/v1/community/experience',
    options: Options(headers: {'Authorization': authToken}),
  );
  return ExpPostPrevRequest.fromJson(response.data);
}
