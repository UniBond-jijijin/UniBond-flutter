import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/view/screens/letter/letter_write_screen.dart';
import 'package:unibond/view/widgets/custon_elevated_button.dart';

class LetterReadScreen extends StatefulWidget {
  final Letter letter;

  const LetterReadScreen({super.key, required this.letter});

  @override
  _LetterReadScreenState createState() => _LetterReadScreenState();
}

class _LetterReadScreenState extends State<LetterReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('받은 편지'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.letter.isliked! ? Icons.bookmark : Icons.bookmark_border,
            ),
            onPressed: () {
              setState(() {
                widget.letter.isliked = !widget.letter.isliked!;
              });
              // 북마크 상태->db저장 필요
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.letter.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.letter.content,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              CustomElevatedButton(
                  text: "답장 쓰기",
                  screenRoute: () {
                    Get.to(() => LetterWriteScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
