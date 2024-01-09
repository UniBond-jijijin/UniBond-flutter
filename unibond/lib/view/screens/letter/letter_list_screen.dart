import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/all_letters.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/letter/letter_read_mine_screen.dart';
import 'package:unibond/view/screens/letter/letter_read_screen.dart';
import 'package:unibond/view/screens/user/other_profile_screen.dart';

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
    return SafeArea(
      child: Scaffold(
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
            FutureBuilder(
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

                    return Column(
                      children: [
                        buildAppBar(allLettersRequest),
                        buildReceiverProfile(allLettersRequest),
                        buildLetterList(allLettersRequest, myToken),
                      ],
                    );
                  } else {
                    return const Center(child: Text("아직 편지가 없어요"));
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget buildReceiverProfile(AllLettersRequest allLettersRequest) {
    var receiverProfileImg = allLettersRequest.result.receiverProfileImg;
    var receiverName = allLettersRequest.result.receiverName;
    var receiverDiseaseName = allLettersRequest.result.receiverDiseaseName;
    var receiverId = allLettersRequest.result.receiverId;

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 0, 20),
      child: GestureDetector(
        onTap: () {
          // 다른 사람 프로필 조회
          Get.to(() => OtherProfileScreen(postOwnerId: receiverId));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // 좌측 정렬
          children: [
            ClipOval(
              child: receiverProfileImg.isNotEmpty
                  ? Image.network(
                      receiverProfileImg,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/user_image.jpg',
                      width: 50,
                      height: 50,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    receiverName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 280,
                    child: Text(
                      receiverDiseaseName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(AllLettersRequest allLettersRequest) {
    return AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  Widget buildLetterList(AllLettersRequest allLettersRequest, String myToken) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: allLettersRequest.result.letterList.length,
          itemBuilder: (context, index) {
            final letter = allLettersRequest.result.letterList[index];

            final sentDate =
                letter.sentDate.split("T")[0].split("-").join(". ");

            Color backgroundColor = letter.senderId.toString() == myToken
                ? Color.lerp(widget.backgroundColor1, Colors.white, 0.3)!
                : Color.lerp(widget.backgroundColor2, Colors.white, 0.3)!;

            return GestureDetector(
              onTap: () {
                if (letter.senderId == allLettersRequest.result.loginId) {
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  elevation: 7.0, // 카드 그림자 깊이
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(sentDate, style: letterInfoTextStyle),
                        Text(letter.letterTitle,
                            style: letterListTitleTextStyle),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "From. ${letter.senderName}",
                            style: letterInfoTextStyle,
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
    );
  }
}
