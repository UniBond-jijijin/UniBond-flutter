import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/all_letter_boxs.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/letter/letter_list_screen.dart';

class LetterBoxScreen extends StatefulWidget {
  const LetterBoxScreen({super.key});

  @override
  State<LetterBoxScreen> createState() => _LetterBoxScreenState();
}

class _LetterBoxScreenState extends State<LetterBoxScreen> {
  Future<LetterBoxRequest>? myLetterBox;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    myLetterBox = getMyLetterBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경화면
          Positioned.fill(
            child: Semantics(
              label: '편지함 감성 일러스트',
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/letterbackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          // 편지함과 좋아함
          Positioned(
            top: 45,
            left: 22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                  child: const Text(
                    '편지함',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                // 좋아함 기능 미구현으로 인한 주석처리
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       currentIndex = 1;
                //     });
                //   },
                //   child: Text(
                //     '좋아함',
                //     style: TextStyle(
                //       fontWeight: currentIndex == 1
                //           ? FontWeight.bold
                //           : FontWeight.normal,
                //       fontSize: 20,
                //       color: Colors.black, // Text color
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Letter Papers
          Positioned.fill(
            top: 100,
            child: buildLetterBoxBody(context),
          ),
        ],
      ),
    );
  }

  Widget buildLetterBoxBody(BuildContext context) {
    return FutureBuilder(
      future: myLetterBox,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
              ),
              // const CircularProgressIndicator(),
            ],
          ));
        } else if (snapshot.hasError) {
          return const Center(child: Text('편지함에서 데이터를 가져올 수 없습니다.'));
        } else if (snapshot.hasData) {
          LetterBoxRequest myLetterBox = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: myLetterBox.result.letterRoomList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final letterBox = myLetterBox.result.letterRoomList?[index];
                    final List<List<Color>> colorSets = [
                      [const Color(0xFFD08EFF), const Color(0xFFFFACC6)],
                      [const Color(0xFFFF88AC), const Color(0xFFFFE9CC)],
                      [const Color(0xFF99B9FF), const Color(0xFFCA80FF)],
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

                    final recentLetterSentDate = letterBox!.recentLetterSentDate
                        .split("T")[0]
                        .split("-")
                        .join(". ");

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => LetterList(
                            backgroundColor1: const Color(0xFFFFA3C0),
                            backgroundColor2: const Color(0xFFA3C1FF),
                            letterRoomId: letterBox.letterRoomId.toString(),
                          ),
                        );
                      },
                      child: Semantics(
                        label: '감성 편지 봉투',
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                          padding: EdgeInsets.zero,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                top: 20,
                                left: 160,
                                child: Image.asset(
                                  'assets/images/letterline2.png',
                                  height: 160,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: -10,
                                child: Image.asset(
                                  'assets/images/rectangleTop.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -10,
                                child: Image.asset(
                                  'assets/images/rectangleTop.png',
                                  width: 400,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Image.asset(
                                  'assets/images/rectangleSide.png',
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: -4,
                                child: Image.asset(
                                  'assets/images/rectangleSide.png',
                                  height: 200,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Positioned(
                                bottom:
                                    58, // Adjust this value for vertical positioning
                                right:
                                    8, // Adjust this value for horizontal positioning
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 24),
                                      child: Text(
                                        recentLetterSentDate,
                                        style: letterBoxTextStyle,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 24),
                                      child: Text(
                                        letterBox.senderNick,
                                        style: letterBoxTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Positioned(
                                bottom: 26,
                                left: 30,
                                child: Text(
                                  'UniBond',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Pinyon_Script',
                                  ),
                                ),
                              ),
                              // 프사 추가
                              Positioned(
                                top: 26,
                                left: 30,
                                child: ClipOval(
                                  child: letterBox.senderProfileImg.isNotEmpty
                                      ? Image.network(
                                          letterBox.senderProfileImg,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/user_image.jpg',
                                          width: 40,
                                          height: 40,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text("아직 편지가 없어요"));
        }
      },
    );
  }
}
