import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(fontFamily: 'Pretendard'),
    );
  }
}
