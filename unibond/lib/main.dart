import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/letter/letter_success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LetterSuccessScreen(),
    );
  }
}
