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
      body: Obx(
        () => ListView.builder(
          itemCount: widget.letterController.letterRoom.length,
          itemBuilder: (context, index) {
            final letterBox = widget.letterController.letterRoom[index];
            final List<List<Color>> colorSets = [
              [const Color(0xFFD08EFF), const Color(0xFFFFACC6)],
              [const Color(0xFFFF88AC), const Color(0xFFFFE9CC)],
              [const Color(0xFF99B9FF), const Color(0xFFCA80FF)],
            ];

            final colorSet = colorSets[index % colorSets.length];

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
                          Text(letterBox.recentLetterSentDate,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8), // 간격 추가
                      Text('보낸 사람: ${letterBox.senderNick}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
