import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  final bool? enable;
  final int? minLines;
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
    this.minLines = 1,
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
        maxLength: widget.maxLength ?? 5,
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
        minLines: widget.expands == true ? 1 : widget.minLines,
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: Colors.grey[50],
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

class MyCustomTextFormFieldWithoutMaxLength extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines; // 추가
  final bool? expands; // 추가
  final TextAlign textAlign; // 추가
  final TextAlignVertical textAlignVertical; // 추가
  final bool? showClearIcon;
  final bool? onlyNumber;

  const MyCustomTextFormFieldWithoutMaxLength({
    this.onlyNumber = false,
    this.showClearIcon = false,
    this.textAlign = TextAlign.start, // 기본값을 왼쪽으로 설정
    this.textAlignVertical = TextAlignVertical.top, // 기본값을 상단으로 설정
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines, // 추가
    this.expands, // 추가
    super.key,
  });

  @override
  State<MyCustomTextFormFieldWithoutMaxLength> createState() =>
      _MyCustomTextFormFieldWithoutMaxLengthState();
}

class _MyCustomTextFormFieldWithoutMaxLengthState
    extends State<MyCustomTextFormFieldWithoutMaxLength> {
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
        keyboardType:
            widget.onlyNumber! ? TextInputType.number : null, // 숫자 키보드만 표시
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
        minLines:
            widget.expands == true ? null : (widget.maxLines ?? 1), // 수정된 부분
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: Colors.grey[50],
          filled: true,
          suffixIcon: widget.showClearIcon!
              ? IconButton(
                  // 추가한 부분
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // 아이콘 버튼 클릭 시 텍스트 필드 내용 지우기
                    widget.controller?.clear();
                  },
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
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

class MyCustomTextFormFieldWithNickname extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onChanged2;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines; // 추가
  final bool? expands; // 추가
  final TextAlign textAlign; // 추가
  final TextAlignVertical textAlignVertical; // 추가
  final bool? showClearIcon;
  final bool? onlyNumber;

  const MyCustomTextFormFieldWithNickname({
    this.onlyNumber = false,
    this.showClearIcon = false,
    this.textAlign = TextAlign.start, // 기본값을 왼쪽으로 설정
    this.textAlignVertical = TextAlignVertical.top, // 기본값을 상단으로 설정
    this.enable,
    required this.onChanged,
    this.onChanged2,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines, // 추가
    this.expands, // 추가
    super.key,
  });

  @override
  State<MyCustomTextFormFieldWithNickname> createState() =>
      _MyCustomTextFormFieldWithNicknameState();
}

class _MyCustomTextFormFieldWithNicknameState
    extends State<MyCustomTextFormFieldWithNickname> {
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
        keyboardType:
            widget.onlyNumber! ? TextInputType.number : null, // 숫자 키보드만 표시
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
        minLines:
            widget.expands == true ? null : (widget.maxLines ?? 1), // 수정된 부분
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: Colors.grey[50],
          filled: true,
          suffixIcon: IconButton(
            icon: const Text(
              '중복 확인',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
                color: primaryColor,
              ),
            ),
            onPressed: () async {
              try {
                String nickname = widget.controller!.text.trim();
                var dio = Dio();
                String url = 'http://3.35.110.214/api/v1/members/duplicate';
                Map<String, dynamic> queryParams = {"nickname": nickname};
                var response = await dio.get(url, queryParameters: queryParams);

                if (response.statusCode == 200) {
                  int responseCode = response.data["code"];
                  if (!mounted) return;
                  // 중복 검사 결과에 따라 대화 상자를 띄움
                  if (responseCode == 1700) {
                    // 이미 존재하는 닉네임인 경우
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('알림'),
                        content: const Text('이미 사용중인 닉네임입니다. \n닉네임을 변경해주세요.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  } else if (responseCode == 1701) {
                    // 사용 가능한 닉네임인 경우
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('알림'),
                        content: const Text('사용 가능한 닉네임입니다!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  print(7);
                  print(
                      'Failed to send nickname verification or unexpected response format.');
                }
              } catch (e) {
                print(8);
                print('Error: $e');
              }
            },
          ),
          contentPadding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
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
