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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 150,
                child: const Text(
                  "회원 가입",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
          CustomTextFormField(hint: "이메일"),
          CustomTextFormField(hint: "아이디"),
          CustomTextFormField(hint: "비밀번호"),
          SizedBox(height: 20),
          CustomElevatedButton(text: "회원 가입"),
        ],
      ),
    );
  }
}
