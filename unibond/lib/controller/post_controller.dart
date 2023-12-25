import 'package:get/get.dart';
import 'package:unibond/domain/post/post_repository.dart';
import 'package:unibond/domain/post/pre_post_model.dart';

class PostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <PrevPost>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPostsList();
  }

  Future<void> getPostsList() async {
    List<PrevPost> posts = await _postRepository.getPostsList();
    this.posts.value = posts;
  }

  Future<bool> uploadPost(String content) async {
    bool isSuccess = await _postRepository.uploadPost(content);
    return isSuccess;
  }
}
