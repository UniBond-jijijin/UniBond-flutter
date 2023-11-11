import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/screens/home_screen.dart';
import 'package:unibond/widgets/custom_text_form_field.dart';
import 'package:unibond/widgets/custon_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

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
                  "로그인 화면",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _loginFrom(),
          ],
        ),
      ),
    );
  }

  Widget _loginFrom() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: "아이디",
            funvalidator: (value) {},
          ),
          CustomTextFormField(
            hint: "비밀번호",
            funvalidator: (value) {},
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            text: "로그인",
            screenRoute: () => Get.to(() => const HomeScreen()),
          ),
        ],
      ),
    );
  }
}
