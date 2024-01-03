import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final funvalidator;
  final String? value;
  final controller;

  const CustomTextArea({
    super.key,
    required this.hint,
    required this.funvalidator,
    this.value,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: TextFormField(
        controller: controller,
        initialValue: value,
        maxLines: 20,
        validator: funvalidator,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          hintText: "내용을 입력하세요.",
          hintStyle: TextStyle(fontSize: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
