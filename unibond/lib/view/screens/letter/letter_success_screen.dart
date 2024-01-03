import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
import 'package:unibond/view/widgets/custon_elevated_button.dart';

class LetterSuccessScreen extends StatefulWidget {
  @override
  _LetterSuccessScreenState createState() => _LetterSuccessScreenState();
}

class _LetterSuccessScreenState extends State<LetterSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('전송 완료'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                'assets/images/send.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 60),

            Image.asset(
              'assets/images/sendsuccess.png',
              width: 200,
            ),
            SizedBox(height: 15),

            Image.asset(
              'assets/images/sendhour.png',
              width: 200,
            ),
            SizedBox(height: 300), // Add spacing between letters

            // CustomElevatedButton at the bottom
            CustomElevatedButton(
              text: "편지함으로",
              screenRoute: () {
                Get.to(() => LetterBoxScreen(
                      fakeEnvelopes: [
                        LetterEnvelope(date: '2023-10-15', sender: '지지진'),
                        LetterEnvelope(date: '2023-10-14', sender: '진지지'),
                        LetterEnvelope(date: '2023-10-14', sender: '지진지'),
                      ],
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
