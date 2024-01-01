// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/controller/dto/post_upload_req_dto.dart';
import 'package:unibond/domain/post/post_provider.dart';
import 'package:unibond/domain/post/pre_post_model.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<List<PrevPost>> getPostsList() async {
    try {
      Response response = await _postProvider.getPostsList();
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

  Future<bool> uploadPost(String content) async {
    try {
      final PostUploadReqDto postUploadReqDto = PostUploadReqDto(content);
      Response response =
          await _postProvider.uploadPost(postUploadReqDto.toJson());
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
