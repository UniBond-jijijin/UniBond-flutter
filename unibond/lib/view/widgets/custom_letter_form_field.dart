import 'package:flutter/material.dart';

class CustomLetterFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final funvalidator;
  final String? value;

  const CustomLetterFormField({
    super.key,
    required this.hint,
    required this.controller,
    required this.funvalidator,
    this.value,
    required InputDecoration decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        initialValue: value ?? "",
        validator: funvalidator,
        controller: controller,
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
