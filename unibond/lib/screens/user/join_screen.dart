import 'package:flutter/material.dart';
import 'package:unibond/widgets/custom_text_form_field.dart';
import 'package:unibond/widgets/custon_elevated_button.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text(
                "회원 가입",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _joinFrom(),
          ],
        ),
      ),
    );
  }

  Widget _joinFrom() {
    return const Form(
      child: Column(
        children: [
          CustomTextFormField(hint: "이메일을 입력하세요"),
          CustomTextFormField(hint: "아이디를 입력하세요"),
          CustomTextFormField(hint: "비밀번호를 입력하세요"),
          CustomElevatedButton(text: "회원 가입"),
        ],
      ),
    );
  }
}
