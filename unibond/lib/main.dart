import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';

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
        home: LetterBoxScreen(fakeEnvelopes: [
          LetterEnvelope(date: '2023-10-15', sender: '지지진'),
          LetterEnvelope(date: '2023-10-14', sender: '진지지'),
          LetterEnvelope(date: '2023-10-14', sender: '지진지'),
          //추가 편지봉투를 여기에 추가
        ])
        // home: DetailScreen(
        //   id: 0,
        // ), // 임시 스플래시화면
        );
  }
}
