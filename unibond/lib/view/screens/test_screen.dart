import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/letter_controller.dart';
import 'package:unibond/domain/letter/pre_receive_letter.dart';
import 'package:unibond/domain/letter/pre_send_letter.dart';

class MyHomePage extends StatelessWidget {
  final LetterController _letterController = Get.put(LetterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letter Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _letterController.getSentLetters();
              },
              child: Text('Get Sent Letters'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _letterController.getReceivedLetters();
              },
              child: Text('Get Received Letters'),
            ),
            Obx(() {
              final sentLetters = _letterController.getsendletter;
              final receivedLetters = _letterController.getreceiveletter;

              return Column(
                children: [
                  Text('Sent Letters:'),
                  if (sentLetters != null)
                    for (var letter in sentLetters)
                      Text('${letter.content} - ${letter.sendDate}'),
                  SizedBox(height: 20),
                  Text('Received Letters:'),
                  if (receivedLetters != null)
                    for (var letter in receivedLetters)
                      Text('${letter.content} - ${letter.sendDate}'),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
