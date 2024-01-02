import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/qna_home_screen.dart';
import 'package:unibond/controller/user_controller.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/widgets/custom_text_form_field.dart';
import 'package:unibond/view/widgets/custon_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final UserController u = Get.put(UserController());
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

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
            funvalidator: validateId,
            controller: _nicknameController,
          ),
          CustomTextFormField(
            controller: _passwordController,
            hint: "비밀번호",
            funvalidator: validatePassword,
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            text: "로그인",
            screenRoute: () async {
              if (isValid(_formKey)) {
                // 임시
                var token = await u.login(_nicknameController.text.trim(),
                    _passwordController.text.trim());
                if (token != "-1") {
                  print("토큰 정상적으로 받음");
                  Get.to(() => const HomeScreen());
                } else {
                  print("토큰 못받음");
                  Get.snackbar("로그인 시도", "로그인 실패");
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 90.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("비밀번호 찾기"),
                ),
                const VerticalDivider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => JoinScreen());
                  },
                  child: const Text("회원가입"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
