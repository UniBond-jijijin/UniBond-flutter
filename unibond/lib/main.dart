import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/letter_controller.dart'; // LetterController를 가져옵니다.
import 'package:unibond/view/screens/letter/letter_write_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Title',
      home: LetterWriteScreen(), // 앱의 초기 화면을 설정합니다.
      initialBinding: InitialBinding(), // 여기에서 LetterController를 초기화합니다.
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LetterController()); // LetterController를 등록합니다.
  }
}
