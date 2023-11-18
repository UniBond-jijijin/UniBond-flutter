import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/screens/user/join_screen.dart';
import 'package:unibond/screens/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // 임시 스플래시화면
    );
  }
}
