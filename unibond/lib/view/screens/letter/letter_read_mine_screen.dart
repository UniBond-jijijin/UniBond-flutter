import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/sent_letter_detail.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class MyLetterReadScreen extends StatefulWidget {
  // final ReceivedLetterDetail receivedLetterDetail;
  final String letterId;

  const MyLetterReadScreen({Key? key, required this.letterId})
      : super(key: key);

  @override
  _LetterReadScreenState createState() => _LetterReadScreenState();
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
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/letterread.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                  return Center(child: Text('편지리스트 스냅샷에러: ${snapshot.error}'));
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
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/send.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text(
                                          '보낸 시간.',
                                          style: letterTextStyle,
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
                                            style: letterTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                    color: Colors.grey, thickness: 1.0),
                                const SizedBox(height: 20),
                                Text(
                                  title!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  content!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
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
