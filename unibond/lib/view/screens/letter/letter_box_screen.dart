import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/letter_controller.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/letter/letter_list_screen.dart';
import 'package:unibond/view/screens/user/profile_screen.dart';
import 'package:unibond/view/widgets/navigator.dart';

class LetterBoxScreen extends StatefulWidget {
  final LetterController letterController = Get.put(LetterController());

  @override
  _LetterBoxScreenState createState() => _LetterBoxScreenState();
}

class _LetterBoxScreenState extends State<LetterBoxScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 호출할 위치에 다음 코드 추가
    widget.letterController.getAllLetterRooms();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경화면
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/letterbackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // 편지함과 좋아함
          Positioned(
            top: 50,
            left: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          : FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black, // Text color
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
                      fontWeight: currentIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Letter Papers
          Positioned.fill(
            top: 120,
            child: Expanded(
              child: ListView.builder(
                itemCount: widget.letterController.letterRoom.length,
                itemBuilder: (context, index) {
                  final letterBox = widget.letterController.letterRoom[index];
                  final List<List<Color>> colorSets = [
                    [Color(0xFFD08EFF), Color(0xFFFFACC6)],
                    [Color(0xFFFF88AC), Color(0xFFFFE9CC)],
                    [Color(0xFF99B9FF), Color(0xFFCA80FF)],
                  ];

                  final colorSet = colorSets[index % colorSets.length];

                  String plane;
                  if (colorSet == colorSets[0]) {
                    plane = 'purpleplane.png';
                  } else if (colorSet == colorSets[1]) {
                    plane = 'pinkplane.png';
                  } else {
                    plane = 'blueplane.png';
                  }

                  String planewiggle = 'planewiggle.png';

                  return GestureDetector(
                    onTap: () {
                      // TODO: 각 편지를 구분하는 id 넘기기
                      Get.to(
                        () => LetterList(
                          backgroundColor1: colorSet[0],
                          backgroundColor2: colorSet[1],
                          sender: letterBox.senderNick,
                          date: letterBox.recentLetterSentDate,
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
                          Positioned(
                            right: 30,
                            top: 20,
                            child: Image.asset(
                              'assets/images/$planewiggle',
                              width: 100,
                              height: 90,
                            ),
                          ),
                          Positioned(
                            right: 80,
                            top: 40,
                            child: Image.asset(
                              'assets/images/$plane',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Positioned(
                            top: 80,
                            bottom: 0,
                            right: 10,
                            child: Image.asset(
                              'assets/images/letterline.png',
                              width: 200,
                              height: 200,
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 100,
                            child: Transform.rotate(
                              angle: 90 *
                                  3.141592653589793 /
                                  180, // 90 degrees in radians
                              child: Image.asset(
                                'assets/images/letterline2.png',
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/rectangleTop.png',
                              width: 400,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/rectangleTop.png',
                              width: 400,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Positioned(
                                bottom:
                                    8, // Adjust this value for vertical positioning
                                right:
                                    8, // Adjust this value for horizontal positioning
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        letterBox.recentLetterSentDate,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                          '보낸 사람: ${letterBox.senderNick}'),
                                    ),
                                  ],
                                ),
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
            ),
          ),
        ],
      ),
    );
  }
}
