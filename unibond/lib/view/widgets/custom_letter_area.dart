import 'package:flutter/material.dart';

class CustomLetterArea extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final funvalidator;
  final String? value;

  const CustomLetterArea({
    super.key,
    required this.hint,
    required this.controller,
    required this.funvalidator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        expands: true,
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
