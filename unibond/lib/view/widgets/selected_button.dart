import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';

class SignupEitherButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SignupEitherButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? primaryColor : Colors.white,
        minimumSize: const Size(80, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}
