// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/controller/dto/post_upload_req_dto.dart';
import 'package:unibond/domain/post/post_provider.dart';
import 'package:unibond/domain/post/pre_post_model.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  // QnA
  Future<List<PrevPost>> getQnaPostsList() async {
    try {
      Response response = await _postProvider.getQnaPostsList();
      dynamic body = response.body;
      CodeMsgResDto codeMsgResDto = CodeMsgResDto.fromJson(body);

      if (codeMsgResDto.code == 1000) {
        Map<String, dynamic> tempMap = codeMsgResDto.result;
        List<dynamic> templist = tempMap["postPreviewList"];
        List<PrevPost> postPreviewList =
            templist.map((post) => PrevPost.fromJson(post)).toList();
        return postPreviewList;
        // PrevPost
      } else {
        throw Exception("Failed to get data");
      }
    } catch (err) {
      print("Failed to get posts list: $err");
      rethrow;
    }
  }

  Future<bool> uploadQnaPost(String content) async {
    try {
      final QnAPostUploadReqDto postUploadReqDto = QnAPostUploadReqDto(content);
      Response response =
          await _postProvider.uploadQnaPost(postUploadReqDto.toJson());
      // 테스트
      print('콘텐츠내용테스트');
      print(postUploadReqDto.content);
      print(response.body);
      print(response.body["isSuccess"]);

      bool isSuccess = response.body["isSuccess"];
      return isSuccess;
    } catch (err) {
      print("Failed to upload post: $err");
      rethrow;
    }
  }

  // 경험공유
  Future<List<PrevPost>> getExpPostsList() async {
    try {
      Response response = await _postProvider.getExpPostsList();
      dynamic body = response.body;
      CodeMsgResDto codeMsgResDto = CodeMsgResDto.fromJson(body);

      if (codeMsgResDto.code == 1000) {
        Map<String, dynamic> tempMap = codeMsgResDto.result;
        List<dynamic> templist = tempMap["postPreviewList"];
        List<PrevPost> postPreviewList =
            templist.map((post) => PrevPost.fromJson(post)).toList();
        return postPreviewList;
        // PrevPost
      } else {
        throw Exception("Failed to get data");
      }
    } catch (err) {
      print("Failed to get posts list: $err");
      rethrow;
    }
  }

  Future<bool> uploadExpPost(String content) async {
    try {
      final ExpPostUploadReqDto postUploadReqDto = ExpPostUploadReqDto(content);
      Response response =
          await _postProvider.uploadExpPost(postUploadReqDto.toJson());
      // 테스트
      print(response.body);
      print(response.body["isSuccess"]);

      bool isSuccess = response.body["isSuccess"];
      return isSuccess;
    } catch (err) {
      print("Failed to upload post: $err");
      rethrow;
    }
  }
}
