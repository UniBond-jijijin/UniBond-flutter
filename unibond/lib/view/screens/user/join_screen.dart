import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/user_controller.dart';
import 'package:unibond/view/screens/user/login_screen.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/widgets/custom_text_form_field.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class JoinScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final UserController u = UserController();
  final _userId = TextEditingController();
  final _password = TextEditingController();
  final _nickname = TextEditingController();
  final _diseaseId = TextEditingController();
  final _diseaseTiming = TextEditingController();
  final _gender = TextEditingController();
  final _bio = TextEditingController();
  final _interestList = TextEditingController();

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
            hint: "아이디",
            funvalidator: validateId,
            controller: _userId,
          ),
          CustomTextFormField(
            hint: "비밀번호",
            funvalidator: validatePassword,
            controller: _password,
          ),
          CustomTextFormField(
            hint: "별명",
            funvalidator: validateId,
            controller: _nickname,
          ),
          CustomTextFormField(
            hint: "질병 이름",
            // TODO: 질병이름 -> Id변경
            controller: _diseaseId,
          ),
          CustomTextFormField(
            hint: "진단 시기",
            controller: _diseaseTiming,
          ),
          CustomTextFormField(
            hint: "성별",
            controller: _gender,
          ),
          CustomTextFormField(
            hint: "한줄 소개",
            controller: _bio,
          ),
          CustomTextFormField(
            hint: "관심사",
            controller: _interestList,
          ),
          // 임시
          // CustomTextFormField(
          //   hint: "이메일",
          //   funvalidator: validateEmail,
          // ),

          const SizedBox(height: 20),
          CustomElevatedButton(
            text: "회원 가입",
            screenRoute: () {
              if (isValid(_formKey)) {
                // TODO: 회원가입 로직 필요
                var userIdNum = u.join(
                  _userId.text.trim(),
                  _password.text.trim(),
                  _diseaseId.text.trim(),
                  _diseaseTiming.text.trim(),
                  _gender.text.trim(),
                  _nickname.text.trim(),
                  _bio.text.trim(),
                  _interestList.text.trim(),
                );

                print(userIdNum);
                // user별 IdNum 저장
                Get.to(() => LoginScreen());
              }
            },
          ),
          TextButton(
            onPressed: () {
              Get.to(() => LoginScreen());
            },
            child: const Text("이미 회원가입 하셨나요?"),
          ),
        ],
      ),
    );
  }
}
