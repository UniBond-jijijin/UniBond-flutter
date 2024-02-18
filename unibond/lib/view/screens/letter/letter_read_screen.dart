import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/block_model.dart';
import 'package:unibond/model/letter/received_letter_detail.dart';
import 'package:unibond/repository/blocking_repository.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/confirm_dialog.dart';
import 'package:unibond/view/screens/letter/letter_write_screen.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class LetterReadScreen extends StatefulWidget {
  // final ReceivedLetterDetail receivedLetterDetail;
  final String letterId;
  final String senderName;
  final String senderId;

  const LetterReadScreen(
      {Key? key,
      required this.letterId,
      required this.senderName,
      required this.senderId})
      : super(key: key);

  @override
  State<LetterReadScreen> createState() => _LetterReadScreenState();
}

class _LetterReadScreenState extends State<LetterReadScreen> {
  Future<ReceivedLetterDetail>? receivedLetterDetail;

  @override
  void initState() {
    super.initState();
    receivedLetterDetail = getReceivedLetterDetail(widget.letterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Semantics(
          label: '뒤로가기',
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'report') {
                showReportConfirmationDialog(context, '편지를');
              } else if (value == 'block') {
                showBlockConfirmationDialog(context, '편지를',
                    int.parse(widget.letterId), _handleBlockLetter);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'report',
                child: Text('신고하기'),
              ),
              const PopupMenuItem<String>(
                value: 'block',
                child: Text('삭제 하기'),
              ),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: [
          Semantics(
            label: '감성 편지지',
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/letter.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Center(
          //   child: Image.asset(
          //     'assets/images/logolight.png',
          //     width: 350,
          //     height: 350,
          //   ),
          // ),
          FutureBuilder(
              future: receivedLetterDetail,
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
                  return const Center(child: Text('편지 목록을 불러오지 못했습니다.'));
                } else if (snapshot.hasData) {
                  ReceivedLetterDetail receivedLetterDetail = snapshot.data!;
                  final result = receivedLetterDetail.result;
                  var tempArrivalDate = receivedLetterDetail.result.arrivalDate;
                  var arrivalDate =
                      tempArrivalDate!.split("T")[0].split("-").join(".");
                  var arrivalTime =
                      tempArrivalDate.split("T")[1].split(".")[0].split(":");
                  var senderName = widget.senderName;
                  var title = result.title;
                  var content = result.content;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(28, 40, 28, 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 60),
                                    Row(
                                      children: [
                                        Semantics(
                                          label: '종이비행기',
                                          child: Image.asset(
                                            'assets/images/send.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text(
                                          '도착 시간.',
                                          style: letterInfoTextStyle,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 36.0),
                                          child: Text(
                                            '$arrivalDate   ${arrivalTime[0]}:${arrivalTime[1]}',
                                            style: letterInfoTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                    color: Colors.grey, thickness: 1.0),
                                const SizedBox(height: 12),
                                Text(
                                  title!,
                                  style: letterReadTitleTextStyle,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  content!,
                                  style: letterContentTextStyle,
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'from. $senderName',
                                      style: letterInfoTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Semantics(
                            label: '답장 쓰기',
                            child: CustomElevatedButton(
                              text: "답장 쓰기",
                              screenRoute: () {
                                Get.to(() => LetterWriteScreen(
                                    receiverId: widget.senderId));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("편지가 없어요"));
                }
              })
        ],
      ),
    );
  }

  // 편지 차단시 실행되는 함수
  void _handleBlockLetter(int letterId) {
    BlockingLetter blockingLetter = BlockingLetter(blockedLetterId: letterId);
    blockLetter(blockingLetter).then((value) => Get.back());
  }
}
