import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(),
    );
  }
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
    );
  }
}
