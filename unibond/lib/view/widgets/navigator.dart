import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '하단 메뉴바',
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Semantics(
              label: '홈',
              child: Icon(Icons.home),
            ),
            tooltip: '홈으로 이동',
          ),
          BottomNavigationBarItem(
            icon: Semantics(
              label: '편지함',
              child: Icon(Icons.mail),
            ),
            tooltip: '편지함으로 이동',
          ),
          BottomNavigationBarItem(
            icon: Semantics(
              label: '프로필',
              child: Icon(Icons.person),
            ),
            tooltip: '프로필로 이동',
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
