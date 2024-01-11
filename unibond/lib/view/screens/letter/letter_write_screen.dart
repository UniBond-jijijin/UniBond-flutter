import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/send_letter.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/toast.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/letter/letter_success_screen.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class LetterWriteScreen extends StatelessWidget {
  final String receiverId;
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  LetterWriteScreen({Key? key, required this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l = Get.find<LetterController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('편지 쓰기'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/letter.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '* 전송된 편지는 6시간 후에 도착합니다.',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: "편지 제목을 입력해주세요.",
                        hintStyle: letterInfoTextStyle,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: "오늘은 어떤 이야기를 하고 싶으신가요?",
                          hintStyle: letterContentTextStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      text: "전송하기", // Set the button color
                      screenRoute: () async {
                        if (isValid(_formKey)) {
                          LetterPostRequest letterPostRequest =
                              LetterPostRequest(
                            receiverId: receiverId,
                            title: _titleController.text.trim(),
                            content: _contentController.text.trim(),
                          );

                          var codeMsgResDto =
                              await postLetter(letterPostRequest);
                          if (codeMsgResDto.isSuccess!) {
                            Get.off(() => const LetterSuccessScreen());
                          } else {
                            showToastMessage(codeMsgResDto.msg!);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
