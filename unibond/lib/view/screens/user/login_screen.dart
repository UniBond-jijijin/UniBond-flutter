import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/toast.dart';
import 'package:unibond/util/auth_storage.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/images/send.png',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(height: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MyCustomTextFormField(
                                  onChanged: (value) {},
                                  hintText: '닉네임을 입력하세요',
                                  controller: nicknameController,
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
                                  controller: passwordController,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await isGoogle(
                                              nicknameController.text.trim(),
                                              passwordController.text.trim());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      fontSize: 16,
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
                  Divider(color: Colors.grey[400], thickness: 1.0),
                  // const SizedBox(height: 4),
                  const SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '이 앱은 현대오토에버와 서울사회복지공동모금회의',
                          style: loginTextStyle,
                          overflow: TextOverflow.visible,
                          // maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '지원으로 제작되었습니다.',
                          style: loginTextStyle,
                          overflow: TextOverflow.visible,
                          // maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 구글 심사용 계정 확인
  Future<void> isGoogle(String id, String pw) async {
    await dotenv.load();
    if (id == dotenv.get('MASTER_ID') && pw == dotenv.get('MASTER_PW')) {
      await AuthStorage.saveAuthToken("29");
      Get.off(() => const RootTab());
    } else {
      showToastMessage('로그인 오류가 발생했습니다. \n관리자에게 문의 부탁드립니다.');
    }
  }
}
