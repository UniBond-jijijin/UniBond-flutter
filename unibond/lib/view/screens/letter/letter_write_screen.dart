import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/util/validator_util.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/widgets/custom_letter_area.dart';
import 'package:unibond/view/widgets/custom_letter_elevated_button.dart';
import 'package:unibond/view/widgets/custom_letter_form_field.dart';

class LetterWriteScreen extends StatefulWidget {
  LetterWriteScreen({super.key});

  @override
  _LetterWriteScreenState createState() => _LetterWriteScreenState();
}

class _LetterWriteScreenState extends State<LetterWriteScreen> {
  final _formKey = GlobalKey<FormState>();
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
        title: const Text("편지 작성"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomLetterFormField(
                hint: '제목을 입력하세요',
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "제목",
                  border: OutlineInputBorder(),
                ),
                funvalidator: validateTitle,
              ),
              const SizedBox(height: 16),
              CustomLetterArea(
                hint: '내용을 입력하세요',
                controller: _contentController,
                funvalidator: validateContent,
              ),
              CustomLetterElevatedButton(
                text: '전송하기',
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    Get.off(HomeScreen());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
