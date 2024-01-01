import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/letter/letter_list_screen.dart';
import 'package:unibond/view/screens/user/profile_screen.dart';
import 'package:unibond/view/widgets/navigator.dart';

class LetterEnvelope {
  final String date;
  final String sender;

  LetterEnvelope({required this.date, required this.sender});
}

class LetterBoxScreen extends StatefulWidget {
  const LetterBoxScreen({Key? key, required this.fakeEnvelopes})
      : super(key: key);

  final List<LetterEnvelope> fakeEnvelopes;

  @override
  _LetterBoxScreenState createState() => _LetterBoxScreenState();
}

class _LetterBoxScreenState extends State<LetterBoxScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Text(
                '편지함',
                style: TextStyle(
                    fontWeight: currentIndex == 0
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: Text(
                '좋아함',
                style: TextStyle(
                    fontWeight: currentIndex == 1
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: widget.fakeEnvelopes.length,
        itemBuilder: (context, index) {
          final envelope = widget.fakeEnvelopes[index];
          final List<List<Color>> colorSets = [
            [Color(0xFFD08EFF), Color(0xFFFFACC6)],
            [Color(0xFFFF88AC), Color(0xFFFFE9CC)],
            [Color(0xFF99B9FF), Color(0xFFCA80FF)],
          ];

          final colorSet = colorSets[index % colorSets.length];

          return GestureDetector(
            onTap: () {
              // TODO: 각 편지를 구분하는 id 넘기기
              Get.to(
                () => LetterList(
                  backgroundColor1: colorSet[0],
                  backgroundColor2: colorSet[1],
                  sender: envelope.sender,
                  date: envelope.date,
                ),
              );
            },
            child: Card(
              elevation: 4, // 그림자 효과 추가
              margin: const EdgeInsets.all(20.0), // 여백 추가
              child: Container(
                height: 180,
                width: 160,
                padding: const EdgeInsets.all(16.0), // 내용 여백 추가
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colorSet,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(envelope.date,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8), // 간격 추가
                    Text('보낸 사람: ${envelope.sender}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // 리팩터링 필요함
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
                          LetterEnvelope(date: '2023-10-14', sender: '지진지'),
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
