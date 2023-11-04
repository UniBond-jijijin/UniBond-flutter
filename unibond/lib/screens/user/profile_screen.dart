import 'package:flutter/material.dart';
import 'package:unibond/screens/home_screen.dart';
import 'package:unibond/screens/letter/letter_box_screen.dart';
import 'package:unibond/widgets/navigator.dart';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: ProfileScreen(),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: const Text('사용설명서'),
              onTap: () {
                //내용
                Navigator.pop(context); // 사이드 메뉴 닫기
              },
            ),
            ListTile(
              title: const Text('즐겨찾는 편지'),
              onTap: () {
                //내용
                Navigator.pop(context); // 사이드 메뉴 닫기
              },
            ),
            ListTile(
              title: const Text('고객센터'),
              onTap: () {
                //내용
                Navigator.pop(context); // 사이드 메뉴 닫기
              },
            ),
            ListTile(
              title: const Text('이용약관 및 정책'),
              onTap: () {
                //내용
                Navigator.pop(context); // 사이드 메뉴 닫기
              },
            ),
            ListTile(
              title: const Text('버전 정보'),
              onTap: () {
                //내용
                Navigator.pop(context); // 사이드 메뉴 닫기
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('메인 화면 내용'),
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
