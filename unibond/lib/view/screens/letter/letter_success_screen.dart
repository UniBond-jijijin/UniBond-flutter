import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
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
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Image.asset(
                      'assets/images/send.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 60),
                    Image.asset(
                      'assets/images/sendsuccess.png',
                      width: 200,
                    ),
                    const SizedBox(height: 15),
                    Image.asset(
                      'assets/images/sendhour.png',
                      width: 200,
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
