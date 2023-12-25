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
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        initialValue: value,
        maxLines: 22,
        validator: funvalidator,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: "$hint을(를) 입력하세요",
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
