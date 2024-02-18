import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: '익명 커뮤니티',
          body: 'Q&A 게시판에서는 혼자서 궁금했던 \n질문들에 대해 서로 이야기해 보세요\n\n'
              '경험공유 게시판에서는 나의 일상, \n꿀팁 등을 나눌 수 있어요👨‍👩‍👧‍👧\n\n'
              '다른 사람들의 글에 자유롭게 \n댓글을 남기며 소통해 보세요💜',
          image: Image.asset('assets/images/onboard1.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '편지로 소통하기',
          body:
              '공감되는 글이나 댓글을 작성한 사람이 있다면,\n 그 사람의 프로필에 방문해 보세요!\n\n 더 이야기를 나누고 싶다면 편지 보내기 버튼을 \n통해 먼저 편지를 보내보세요😊\n\n마음이 맞는 친구와 편지로 감정을 나눠요💙\n',
          image: Image.asset('assets/images/onboard2.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '편지 답장보내기',
          body: '편지함 하단의 답장 쓰기 버튼이나\n'
              '개별 편지들의 답장 쓰기 버튼을 통해\n'
              '받은 편지에 답장을 보낼 수 있어요!\n\n'
              '보낸 편지는 3시간 뒤에 도착합니다🤗',
          image: Image.asset('assets/images/onboard3.jpg', height: 300),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text('닫기'),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RootTab()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      skip: const Text("건너뛰기"),
      dotsDecorator: DotsDecorator(
        color: const Color(0xFF7A34AC),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        activeColor: const Color(0xFF7A34AC),
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
      imagePadding: EdgeInsets.fromLTRB(0, 100, 0, 0), // 이미지를 화면 맨 아래에 배치
      pageColor: Color(0xFFF2F2FB),
    );
  }
}
