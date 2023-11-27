import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/view/screens/letter/letter_read_screen.dart';

class LetterList extends StatelessWidget {
  const LetterList({super.key});

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 예제를 위한 임시 데이터 수
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(LetterReadScreen(
                        letter: Letter(
                            id: 1,
                            receiverId: 2,
                            title: "저는 오늘 행복한 하루를 보냈어요.",
                            content: "마음이 잘 통하는 친구를 만난 것 같거든요.",
                            isliked: true),
                      ));
                    },
                    child: Card(
                      elevation: 4.0, // 카드 그림자 깊이
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        width: 300,
                        height: 200,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "From. 오지지",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: Text(
                                "저는 오늘 행복한 하루를 보냈어요",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "2023-11-27",
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
        ],
      ),
    );
  }
}
