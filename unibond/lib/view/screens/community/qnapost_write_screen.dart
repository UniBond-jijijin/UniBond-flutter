import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/qnapost_controller.dart';
import 'package:unibond/resources/toast.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/widgets/custom_textarea.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class QnaWriteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _content = TextEditingController();

  QnaWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Get.find<QnaPostController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('글 쓰기'),
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextArea(
                          controller: _content,
                          hint: "내용",
                          funvalidator: validateContent,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomElevatedButton(
                    text: "작성 완료",
                    screenRoute: () async {
                      if (isValid(_formKey)) {
                        var isSuccess =
                            await p.uploadQnaPost(_content.text.trim());
                        if (isSuccess == true) {
                          showToastMessage("게시물 업로드 성공");
                          // Get.snackbar(
                          //   "알림",
                          //   "업로드 성공",
                          //   snackPosition: SnackPosition.BOTTOM,
                          // );
                          Get.off(() => const RootTab());
                        } else {
                          showToastMessage("게시물 업로드 실패");
                          // Get.snackbar(
                          //   "알림",
                          //   "업로드 실패",
                          //   snackPosition: SnackPosition.BOTTOM,
                          // );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
