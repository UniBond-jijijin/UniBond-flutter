import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/block_model.dart';
import 'package:unibond/model/letter/all_letters.dart';
import 'package:unibond/repository/blocking_repository.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/confirm_dialog.dart';
import 'package:unibond/view/screens/letter/letter_read_mine_screen.dart';
import 'package:unibond/view/screens/letter/letter_read_screen.dart';
import 'package:unibond/view/screens/letter/letter_write_screen.dart';
import 'package:unibond/view/screens/user/other_profile_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';

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
                    return const Center(
                        child: Text('편지리스트에서 데이터를 가져올 수 없습니다.'));
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
        icon: Semantics(
          label: '뒤로 가기',
          child: Icon(Icons.arrow_back_ios),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'report') {
              showReportConfirmationDialog(context, '편지함을');
            } else if (value == 'block') {
              showBlockConfirmationDialog(context, '편지함을',
                  int.parse(widget.letterRoomId), _handleBlockLetterList);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'report',
              child: Text('신고하기'),
            ),
            const PopupMenuItem<String>(
              value: 'block',
              child: Text('차단하기'),
            ),
          ],
          icon: Semantics(
            label: '편지 신고 또는 차단',
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildLetterList(AllLettersRequest allLettersRequest, myToken) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: Stack(
          // Stack을 사용하여 FloatingActionButton이 ListView 위에 올 수 있도록 합니다.
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: allLettersRequest.result.letterList.length,
              itemBuilder: (context, index) {
                final letter = allLettersRequest.result.letterList[index];

                final sentDate =
                    letter.sentDate.split("T")[0].split("-").join(". ");

                Color backgroundColor = letter.senderId.toString() == myToken
                    ? Color.lerp(widget.backgroundColor1, Colors.white, 0.2)!
                    : Color.lerp(widget.backgroundColor2, Colors.white, 0.2)!;

                return GestureDetector(
                  onTap: () async {
                    if (letter.senderId == allLettersRequest.result.loginId) {
                      // 보낸 편지 상세조회 화면 이동
                      Get.to(() => MyLetterReadScreen(
                            letterId: letter.letterId.toString(),
                          ));
                    } else {
                      // 받은 편지 상세조회 화면 이동
                      await Get.to(() => LetterReadScreen(
                            letterId: letter.letterId.toString(),
                            senderName: letter.senderName,
                            senderId: letter.senderId.toString(),
                          ));
                      // 받은 편지가 차단되었을수도 있으므로 화면 업데이트
                      setState(() {});
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
                          // image: const DecorationImage(
                          //   image: AssetImage('assets/images/lettertexture.png'),
                          //   fit: BoxFit.cover,
                          // ),
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
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: Semantics(
                label: '답장 쓰기',
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // 답장 쓰기 버튼을 눌렀을 때의 동작
                    Get.to(() => LetterWriteScreen(
                        receiverId:
                            allLettersRequest.result.receiverId.toString()));
                  },
                  elevation: 4,
                  icon: const Icon(Icons.mode_edit_outlined),
                  label: const Text('답장 쓰기'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.contentColorPink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 편지리스트 차단시 실행되는 함수
  void _handleBlockLetterList(int letterRoomId) {
    BlockingLetterList blockingLetterList =
        BlockingLetterList(blockedLetterRoomId: letterRoomId);
    blockLetterList(blockingLetterList)
        .then((value) => Get.off(() => const RootTab(initialIndex: 1)));
  }
}
