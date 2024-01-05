import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/controller/letter_controller.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LetterWriteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  LetterWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = Get.find<LetterController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('작성중인 편지'),
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
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "제목",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: "내용을 입력하세요...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              CustomElevatedButton(
                text: "편지 전송",
                screenRoute: () async {
                  if (isValid(_formKey)) {
                    var isSuccess = await l.sendLetter(
                      "30",
                      _titleController.text.trim(),
                      _contentController.text.trim(),
                    );
                    if (isSuccess == true) {
                      showToastMessage();
                      print('편지 전송 성공');
                      Get.off(() => const HomeScreen());
                    } else {
                      print('편지 전송 실패');
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

void showToastMessage() {
  Fluttertoast.showToast(
    msg: "전송이 완료되었습니다",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
