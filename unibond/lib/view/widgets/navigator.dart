import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: '홈', tooltip: '홈으로 이동'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail), label: '편지함', tooltip: '편지함으로 이동'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: '프로필', tooltip: '프로필로 이동'),
      ],
      onTap: onTap,
    );
  }
}
