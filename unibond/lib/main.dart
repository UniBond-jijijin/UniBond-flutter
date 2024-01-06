import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/letter/letter_write_screen.dart';
import 'package:unibond/view/widgets/custom_elevated_button.dart';

class LetterReadScreen extends StatefulWidget {
  final Letter letter;

  const LetterReadScreen({Key? key, required this.letter}) : super(key: key);

  @override
  _LetterReadScreenState createState() => _LetterReadScreenState();
}

class _LetterReadScreenState extends State<LetterReadScreen> {
  // Placeholder values for testing
  String arriveDate = '2022-01-01';
  String senderNick = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text('받은 편지'),
            Text(
              '도착시간: $arriveDate',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$senderNick'),
          ),
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/letterread.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Letter {
  final String title;
  final String content;
  bool? isliked;

  Letter({
    required this.title,
    required this.content,
    this.isliked,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LetterReadScreen(
          letter: Letter(
            title: 'Sample Letter',
            content: 'This is a sample letter content.',
            isliked: false,
          ),
        ),
      ),
    );
  }
}
