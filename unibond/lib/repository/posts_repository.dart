import 'package:dio/dio.dart';
import 'package:unibond/model/post/qnapost_request.dart';

// 상세 게시물 조회
Future<QnaPostDetail> getPostDetail(String postId, String memberId) async {
  final dio = Dio();
  final response = await dio.get(
    'http://3.35.110.214/api/v1/community/$postId',
    options: Options(headers: {'Authorization': memberId}),
  );

  return QnaPostDetail.fromJson(response.data);
}
