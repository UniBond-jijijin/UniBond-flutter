import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/post_controller.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/widgets/custom_textarea.dart';
import 'package:unibond/view/widgets/custon_elevated_button.dart';

class WriteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _content = TextEditingController();

  WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('게시물 작성'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // CustomTextFormField(hint: "제목", funvalidator: validateTitle),
              CustomTextArea(
                controller: _content,
                hint: "내용",
                funvalidator: validateContent,
              ),
              CustomElevatedButton(
                text: "작성 완료",
                screenRoute: () async {
                  if (isValid(_formKey)) {
                    var isSuccess = await p.uploadPost(_content.text.trim());
                    if (isSuccess == true) {
                      Get.snackbar("게시글 작성", "업로드 성공");
                      Get.off(() => const HomeScreen());
                    } else {
                      print("글 업로드 실패");
                      Get.snackbar("게시글 작성", "업로드 실패");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
