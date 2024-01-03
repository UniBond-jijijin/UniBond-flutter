import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/widgets/custom_text_form_field.dart';
import 'package:unibond/view/widgets/custom_textarea.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class UpdateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('게시물 수정'),
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
              CustomTextFormField(
                hint: "제목",
                funvalidator: validateTitle,
                value: "하하 이것은 나중에 서버에서 받아올 제목이야.",
              ),
              CustomTextArea(
                hint: "내용",
                funvalidator: validateContent,
                value: "나중에 서버에서 받아올 내용. 나는 배가 고파요. " * 10,
              ),
              CustomElevatedButton(
                text: "수정 완료",
                screenRoute: () {
                  if (isValid(_formKey)) {
                    // TODO: 추후 GetX Obs 기능 사용해서 이전 화면 갱신하기
                    Get.back();
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
