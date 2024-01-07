import 'package:flutter/material.dart';

class CustomLetterElevatedButton extends StatelessWidget {
  final String text;
  final Future<void> Function() funPageRoute;

  const CustomLetterElevatedButton({
    Key? key,
    required this.text,
    required this.funPageRoute,
  }) : super(key: key);

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
      onPressed: () async {
        await funPageRoute();
      },
      child: Text("$text"),
    );
  }
}
