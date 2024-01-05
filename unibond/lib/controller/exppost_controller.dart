import 'package:get/get.dart';
import 'package:unibond/domain/post/deprecated_post_repository.dart';
import 'package:unibond/domain/post/pre_post_model.dart';

class ExpPostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <PrevPost>[].obs;

  @override
  void onInit() {
    super.onInit();
    getExpPostsList();
  }

  Future<void> getExpPostsList() async {
    List<PrevPost> posts = await _postRepository.getExpPostsList();
    this.posts.value = posts;
  }

  Future<bool> uploadExpPost(String content) async {
    bool isSuccess = await _postRepository.uploadExpPost(content);
    return isSuccess;
  }
}
