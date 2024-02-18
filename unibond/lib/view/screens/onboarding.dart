import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:unibond/view/screens/home_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: '게시판',
          body: 'QnA 게시판에서는 궁금했던 개인적인 질문들을 나누고\n'
              '경험공유 게시판에서는 나의 일상, 꿀팁 등을 나눌 수 있어요\n'
              '다른 사용자들의 글에 자유롭게 댓글을 남길 수 있어요',
          image: Image.asset('assets/images/onboard1.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '편지 작성',
          body: '편지를 보내고 싶은 다른 사용자의 프로필에서\n'
              '편지 보내기 버튼을 누르면\n'
              '일대일로 진심을 담아 소통할 수 있어요\n',
          image: Image.asset('assets/images/onboard2.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '편지 답장',
          body: '편지방의 답장 쓰기 버튼을 누르거나\n'
              '개별 편지들의 답장 쓰기 버튼을 누르면\n'
              '받은 편지에 답장을 보낼 수 있어요\n'
              '작성한 편지는 3시간 뒤에 도착해요',
          image: Image.asset('assets/images/onboard3.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '내 프로필',
          body: '프로필 화면에서는 닉네임, 한줄 소개 등을 수정하거나\n'
              '이용약관 및 개인정보 처리방침을 확인할 수 있어요',
          image: Image.asset('assets/images/onboard4.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text('닫기'),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      skip: const Text("건너뛰기"),
      dotsDecorator: DotsDecorator(
        color: Color(0xFF7A34AC),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        activeColor: Color(0xFF7A34AC),
      ),
      curve: Curves.bounceOut,
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF7A34AC),
      ),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
        height: 1.5,
      ),
      imagePadding: EdgeInsets.all(50), // 이미지를 화면 맨 아래에 배치
      pageColor: Color(0xFFF2F2FB),
    );
  }
}
