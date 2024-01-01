import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';

class NextButton extends StatefulWidget {
  final String buttonName;
  final bool isButtonEnabled;
  final VoidCallback? onPressed;
  final Color? color;

  const NextButton({
    required this.onPressed,
    required this.buttonName,
    required this.isButtonEnabled,
    this.color,
    super.key,
  });

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: widget.isButtonEnabled ? widget.onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.color ??
                    (widget.isButtonEnabled ? primaryColor : Colors.grey[200]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.buttonName,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
