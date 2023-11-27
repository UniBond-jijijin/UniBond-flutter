import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/widgets/custom_text_form_field.dart';
import 'package:unibond/view/widgets/custom_textarea.dart';
import 'package:unibond/view/widgets/custon_elevated_button.dart';

class WriteScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              CustomTextFormField(hint: "제목", funvalidator: validateTitle),
              CustomTextArea(hint: "내용", funvalidator: validateContent),
              CustomElevatedButton(
                text: "작성 완료",
                screenRoute: () {
                  if (isValid(_formKey)) {
                    Get.off(() => const HomeScreen());
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
