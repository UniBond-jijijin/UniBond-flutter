import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';

class MyCustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines;
  final bool? expands;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final bool? showClearIcon;
  final bool? onlyNumber;
  final int? maxLength;

  const MyCustomTextFormField({
    this.onlyNumber = false,
    this.showClearIcon = false,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.top,
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines,
    this.expands,
    this.maxLength,
    super.key,
  });

  @override
  State<MyCustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<MyCustomTextFormField> {
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: borderColor,
        width: 0.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 14, 6),
      child: TextFormField(
        maxLength: widget.maxLength ?? 50,
        keyboardType:
            widget.onlyNumber! ? TextInputType.number : null, // 숫자 키보드 표시
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        enabled: widget.enable ?? true,
        onTap: () {
          setState(() {
            showErrorText = false;
          });
        },
        controller: widget.controller,
        cursorColor: cursorColor,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        minLines: widget.expands == true ? null : widget.textFieldMinLine,
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          suffixIcon: widget.showClearIcon!
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.controller?.clear();
                  },
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(7, 12, 14, 12),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
            color: Colors.grey[600],
          ),
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
          enabledBorder: baseBorder,
        ),
      ),
    );
  }
}
