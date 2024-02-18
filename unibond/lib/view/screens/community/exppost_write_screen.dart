import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/exppost_controller.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/toast.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/widgets/custom_textarea.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class ExpWriteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _content = TextEditingController();

  ExpWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Get.find<ExpPostController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('글 쓰기'),
          leading: Semantics(
            label: '뒤로 가기',
            child: ExcludeSemantics(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          '* 게시물 수정 기능은 추후 업데이트를 통해 추가적인 게시판과 함께 제공될 예정입니다. 현재에는 게시물 수정이 불가하다는 점을 유의해주세요 ',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[400], thickness: 1.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Semantics(
                          label: '게시물 내용 작성',
                          child: CustomTextArea(
                            controller: _content,
                            hint: "내용",
                            funvalidator: validateContent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Semantics(
                    label: '게시물 작성 완료',
                    child: CustomElevatedButton(
                      text: "작성 완료",
                      screenRoute: () async {
                        if (isValid(_formKey)) {
                          var isSuccess =
                              await p.uploadExpPost(_content.text.trim());
                          if (isSuccess == true) {
                            showToastMessage("게시물 업로드 성공");
                            Get.off(() => const RootTab());
                          } else {
                            showToastMessage("게시물 업로드 실패");
                          }
                        }
                      },
                    ),
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
