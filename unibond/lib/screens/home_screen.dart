import 'package:flutter/material.dart';
import 'package:unibond/models/letter.dart';
import 'package:unibond/screens/letter/letter_read_screen.dart';
import 'package:unibond/screens/letter/letter_write_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홈 화면"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LetterWriteScreen(),
                  ),
                );
              },
              child: const Text("편지 작성하기"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 예시 편지데이터
                Letter sampleLetter = Letter(
                  title: "안녕하세요! 저는 오늘 정말 행복해요",
                  content: "이건 편지내용인데... 어떤가요..",
                  isBookmarked: true,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LetterReadScreen(letter: sampleLetter),
                  ),
                );
              },
              child: const Text("편지 읽기"),
            ),
          ],
        ),
      ),
    );
  }
}
