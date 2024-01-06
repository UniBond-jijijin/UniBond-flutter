import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final screenRoute;

  const CustomElevatedButton(
      {super.key, required this.text, required this.screenRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color(0xFF9359CD),
        foregroundColor: Colors.white,
      ),
      onPressed: screenRoute,
      child: Text(
        text,
        style: homeMenuTextStyle,
      ),
    );
  }
}
