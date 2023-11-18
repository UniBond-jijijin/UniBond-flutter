import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/screens/user/login_screen.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/widgets/custom_text_form_field.dart';
import 'package:unibond/widgets/custon_elevated_button.dart';

class JoinScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  JoinScreen({super.key});

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: "이메일",
            funvalidator: validateEmail,
          ),
          CustomTextFormField(
            hint: "아이디",
            funvalidator: validateId,
          ),
          CustomTextFormField(
            hint: "비밀번호",
            funvalidator: validatePassword,
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            text: "회원 가입",
            screenRoute: () {
              if (isValid()) {
                Get.to(() => LoginScreen());
              }
            },
          ),
        ],
      ),
    );
  }

  bool isValid() => _formKey.currentState!.validate();
}
