import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class LetterSuccessScreen extends StatelessWidget {
  const LetterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('전송 완료'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    Image.asset(
                      'assets/images/send.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '전송이 완료되었습니다.',
                      style: TextStyle(
                        fontFamily: 'MapoGoldenPier',
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '전송된 편지는 1시간 후에 도착합니다.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    const SizedBox(height: 300),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomElevatedButton(
                text: "편지함으로",
                screenRoute: () {
                  Get.to(() => const RootTab(initialIndex: 1));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
