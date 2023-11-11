import 'package:flutter/material.dart';
import 'package:unibond/models/letter.dart';
import 'package:unibond/screens/letter/letter_read_screen.dart';
import 'package:unibond/screens/letter/letter_write_screen.dart';
import 'package:unibond/screens/letter/letter_box_screen.dart';
import 'package:unibond/screens/user/profile_screen.dart';
import 'package:unibond/widgets/navigator.dart';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: HomeScreen(),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("커뮤니티"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 120,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
      bottomNavigationBar: MyBottomNavigationBar(
        // 현재 선택된 바텀 바 아이콘 인덱스
        currentIndex: 0,
        onTap: (index) {
          // 바텀 바 아이콘을 누를 때 화면 전환
          if (index == 0) {
            // 홈 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            //편지함 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LetterBoxScreen(
                        fakeEnvelopes: [
                          LetterEnvelope(date: '2023-10-15', sender: '지지진'),
                          LetterEnvelope(date: '2023-10-14', sender: '진지지'),
                        ],
                      )),
            );
          } else if (index == 2) {
            // 프로필 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
