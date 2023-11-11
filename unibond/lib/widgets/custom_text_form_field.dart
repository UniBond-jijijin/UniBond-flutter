import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;

  const CustomTextFormField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: hint == "비밀번호" ? true : false,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // ignore: unnecessary_string_interpolations
          hintText: hint == "이메일" ? "$hint을 입력하세요" : "$hint를 입력하세요",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
