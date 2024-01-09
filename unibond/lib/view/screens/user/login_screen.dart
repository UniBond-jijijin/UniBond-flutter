// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unibond/view/screens/home_screen.dart';
// import 'package:unibond/controller/user_controller.dart';
// import 'package:unibond/view/screens/user/join_screen.dart';
// import 'package:unibond/util/validator_util.dart';
// import 'package:unibond/view/widgets/custom_text_form_field.dart';
// import 'package:unibond/view/widgets/custom_elevated_button.dart';

// class LoginScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   final UserController u = Get.put(UserController());
//   final _nicknameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 height: 150,
//                 child: const Text(
//                   "로그인 화면",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             _loginFrom(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loginFrom() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           CustomTextFormField(
//             hint: "아이디",
//             funvalidator: validateId,
//             controller: _nicknameController,
//           ),
//           CustomTextFormField(
//             controller: _passwordController,
//             hint: "비밀번호",
//             funvalidator: validatePassword,
//           ),
//           const SizedBox(height: 20),
//           CustomElevatedButton(
//             text: "로그인",
//             screenRoute: () async {
//               if (isValid(_formKey)) {
//                 // 임시
//                 var token = await u.login(_nicknameController.text.trim(),
//                     _passwordController.text.trim());
//                 if (token != "-1") {
//                   print("토큰 정상적으로 받음");
//                   Get.to(() => const HomeScreen());
//                 } else {
//                   print("토큰 못받음");
//                   Get.snackbar("로그인 시도", "로그인 실패");
//                 }
//               }
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 90.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text("비밀번호 찾기"),
//                 ),
//                 const VerticalDivider(
//                   thickness: 2,
//                   indent: 20,
//                   endIndent: 0,
//                   color: Colors.grey,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.to(() => const JoinScreen());
//                   },
//                   child: const Text("회원가입"),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';
import 'package:unibond/view/widgets/next_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/joinbackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/send.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "반가워요!\nUniBond에\n오신 것을 환영합니다.",
                  style: TextStyle(
                    fontFamily: 'MapoGoldenPier',
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "닉네임과 비밀번호를 입력해서 로그인해주세요",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
                SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MyCustomTextFormField(
                        onChanged: (value) {},
                        // controller: nicknameController,
                        hintText: '닉네임을 입력하세요',
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MyCustomTextFormField(
                        // validator: _validatePassword,
                        // controller: passwordController,
                        onChanged: (value) {},
                        maxLength: 12,
                        maxLines: 1,
                        obscureText: true,
                        hintText: '비밀번호를 입력해주세요',
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: NextButton(
                          onPressed: null,
                          buttonName: '로그인',
                          isButtonEnabled: true,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => JoinScreen());
                        },
                        child: Text(
                          '아직 회원이 아니신가요?',
                          style: TextStyle(
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
    );
  }
}
