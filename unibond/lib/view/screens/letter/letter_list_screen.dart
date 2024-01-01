import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/view/screens/letter/letter_read_screen.dart';

class LetterList extends StatelessWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final String sender;
  final String date;

  const LetterList({
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.sender,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('편지 내용'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            10,
            (index) {
              double topPosition = index * 40.0;
              double leftPosition = index * 5.0;

              Color backgroundColor =
                  index.isEven ? backgroundColor1 : backgroundColor2;

              return Positioned(
                top: topPosition,
                left: leftPosition,
                child: GestureDetector(
                  onTap: () {
                    Get.to(LetterReadScreen(
                      letter: Letter(
                        id: 1,
                        receiverId: 2,
                        title: "저는 오늘 행복한 하루를 보냈어요.",
                        content: "마음이 잘 통하는 친구를 만난 것 같거든요.",
                        isliked: true,
                      ),
                    ));
                  },
                  child: Card(
                    elevation: 7.0, // 카드 그림자 깊이
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2023-11-27",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: Text(
                              "저는 오늘 행복한 하루를 보냈어요",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "From. $sender",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
