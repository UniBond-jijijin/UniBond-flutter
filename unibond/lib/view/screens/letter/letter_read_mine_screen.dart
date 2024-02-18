import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/sent_letter_detail.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';

class MyLetterReadScreen extends StatefulWidget {
  // final ReceivedLetterDetail receivedLetterDetail;
  final String letterId;

  const MyLetterReadScreen({Key? key, required this.letterId})
      : super(key: key);

  @override
  State<MyLetterReadScreen> createState() => _LetterReadScreenState();
}

class _LetterReadScreenState extends State<MyLetterReadScreen> {
  Future<SentLetterDetail>? receivedLetterDetail;

  @override
  void initState() {
    super.initState();
    receivedLetterDetail = getSentLetterDetail(widget.letterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Semantics(
          label: '뒤로 가기',
          child: ExcludeSemantics(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
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
                  SentLetterDetail receivedLetterDetail = snapshot.data!;
                  final result = receivedLetterDetail.result;
                  var tempArrivalDate = receivedLetterDetail.result.sendDate;
                  var sendDate =
                      tempArrivalDate!.split("T")[0].split("-").join(".");
                  var arrivalTime =
                      tempArrivalDate.split("T")[1].split(".")[0].split(":");
                  var title = result.title;
                  var content = result.content;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 16),
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
                                          '보낸 시간.',
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
                                            '$sendDate   ${arrivalTime[0]}:${arrivalTime[1]}',
                                            // '$sendDate   ${(int.parse(arrivalTime[0]) + 1).toString().padLeft(2, '0')}:${arrivalTime[1]}', // 열심히 1시간 더한 흔적..무의미했다고 한다..
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
                                const SizedBox(height: 12),
                                Text(
                                  content!,
                                  style: letterContentTextStyle,
                                ),
                              ],
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
}
