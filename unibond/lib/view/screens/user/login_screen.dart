import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/joinbackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/send.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "반가워요!\nUniBond에\n오신 것을 환영합니다.",
                      style: TextStyle(
                        fontFamily: 'MapoGoldenPier',
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "닉네임과 비밀번호를 입력해서 로그인해주세요",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MyCustomTextFormField(
                            onChanged: (value) {},
                            hintText: '닉네임을 입력하세요',
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MyCustomTextFormField(
                            onChanged: (value) {},
                            maxLength: 12,
                            maxLines: 1,
                            obscureText: true,
                            hintText: '비밀번호를 입력하세요',
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {}, // TODO: 구글만을 위한 로그인 값 전달
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    '로그인',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const JoinScreen());
                            },
                            child: const Text(
                              '아직 회원이 아니신가요?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF5A5A5A),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
