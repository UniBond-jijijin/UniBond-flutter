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
                  fontWeight:
                      currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
                ),
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
                  fontWeight:
                      currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
                ),
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
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(0),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: colorSet,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  // 여러 개의 평행사변형 추가
                  for (int i = 0; i < 10; i++)
                    Positioned(
                      left: 40.0 * i,
                      top: 0,
                      child: Transform(
                        transform: Matrix4.skewX(-0.4),
                        child: Container(
                          width: 13,
                          height: 16,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  for (int i = 0; i < 10; i++)
                    Positioned(
                      left: 40.0 * i,
                      bottom: 0,
                      child: Transform(
                        transform: Matrix4.skewX(-0.4),
                        child: Container(
                          width: 13,
                          height: 16,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  for (int i = 0; i < 6; i++)
                    Positioned(
                      left: 0,
                      bottom: 40.0 * i,
                      child: Transform(
                        transform: Matrix4.skewX(-0.4),
                        child: Container(
                          width: 13,
                          height: 16,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  for (int i = 0; i < 6; i++)
                    Positioned(
                      right: 0,
                      bottom: 40.0 * i,
                      child: Transform(
                        transform: Matrix4.skewX(-0.4),
                        child: Container(
                          width: 13,
                          height: 16,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            envelope.date,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text('보낸 사람: ${envelope.sender}'),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 70),
                        child: Text(
                          'unibond',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Pinyon_Script',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LetterBoxScreen(
                  fakeEnvelopes: [
                    LetterEnvelope(date: '2023-10-15', sender: '지지진'),
                    LetterEnvelope(date: '2023-10-14', sender: '진지지'),
                    LetterEnvelope(date: '2023-10-14', sender: '지진지'),
                  ],
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
