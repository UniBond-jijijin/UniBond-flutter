import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/all_letters.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/view/screens/letter/letter_read_mine_screen.dart';
import 'package:unibond/view/screens/letter/letter_read_screen.dart';

class LetterList extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final String letterRoomId;

  const LetterList({
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.letterRoomId,
    Key? key,
  }) : super(key: key);

  @override
  State<LetterList> createState() => _LetterListState();
}

class _LetterListState extends State<LetterList> {
  Future<AllLettersRequest>? allLettersRequest;
  Future<String>? myToken;

  @override
  void initState() {
    super.initState();
    // allLettersRequest = getAllLettersRequest(widget.letterRoomId);
    // myToken = getAuthToken();
  }

  // 2개 함수 비동기 처리를 위한...
  Future<AllLettersRequest> fetchAllLetters() async {
    allLettersRequest = getAllLettersRequest(widget.letterRoomId);
    return allLettersRequest!;
  }

  Future<String> fetchAuthToken() async {
    myToken = getAuthToken();
    return myToken!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('편지들'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 배경화면
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/letterbackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FutureBuilder(
                future: Future.wait([fetchAllLetters(), getAuthToken()]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                        ),
                        // const CircularProgressIndicator(),
                      ],
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('편지리스트 스냅샷에러: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    AllLettersRequest allLettersRequest =
                        snapshot.data![0] as AllLettersRequest;
                    String myToken = snapshot.data![1] as String;

                    return Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allLettersRequest.result.letterList.length,
                      itemBuilder: (context, index) {
                        final letter =
                            allLettersRequest.result.letterList[index];

                        final sentDate =
                            letter.sentDate.split("T")[0].split("-").join(". ");

                        Color backgroundColor =
                            letter.senderId.toString() == myToken
                                ? widget.backgroundColor1
                                : widget.backgroundColor2;

                        return GestureDetector(
                          onTap: () {
                            if (letter.senderId ==
                                allLettersRequest.result.loginId) {
                              // 보낸 편지 상세조회 화면 이동
                              Get.to(() => MyLetterReadScreen(
                                    letterId: letter.letterId.toString(),
                                  ));
                            } else {
                              // 받은 편지 상세조회 화면 이동
                              Get.to(() => LetterReadScreen(
                                    letterId: letter.letterId.toString(),
                                    senderName: letter.senderName,
                                    senderId: letter.senderId.toString(),
                                  ));
                            }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sentDate,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      letter.letterTitle,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "From. ${letter.senderName}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
                  } else {
                    return const Center(child: Text("아직 편지가 없어요"));
                  }
                }),
          )
        ],
      ),
    );
  }
}
