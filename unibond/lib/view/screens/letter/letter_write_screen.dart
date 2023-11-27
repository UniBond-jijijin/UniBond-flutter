import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LetterWriteScreen extends StatefulWidget {
  const LetterWriteScreen({super.key});

  @override
  _LetterWriteScreenState createState() => _LetterWriteScreenState();
}

class _LetterWriteScreenState extends State<LetterWriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('작성중인 편지'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // 편지 전송하는 코드 추가
              // showToast();
              Get.back(); // 이전 화면 이동
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "제목",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: "내용을 입력하세요...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void showToast() {
//   Fluttertoast.showToast(
//       msg: "전송이 완료되었습니다",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.grey,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
