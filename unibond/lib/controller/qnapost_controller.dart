import 'package:get/get.dart';
import 'package:unibond/domain/post/deprecated_post_repository.dart';
import 'package:unibond/domain/post/pre_post_model.dart';

class QnaPostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <PrevPost>[].obs;

  @override
  void onInit() {
    super.onInit();
    getQnaPostsList();
  }

  Future<void> getQnaPostsList() async {
    List<PrevPost> posts = await _postRepository.getQnaPostsList();
    this.posts.value = posts;
  }

  Future<bool> uploadQnaPost(String content) async {
    bool isSuccess = await _postRepository.uploadQnaPost(content);
    return isSuccess;
  }
}
