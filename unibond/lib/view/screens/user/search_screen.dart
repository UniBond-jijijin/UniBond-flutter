import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/widgets/default_layout.dart';
import 'package:unibond/view/widgets/next_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  Timer? debouncer;

  // 질환 검색 api연결 필요
  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void searchDisease(String query) => debounce(
        () async {},
      );

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isSingleChildScrollView: true,
      title: '질환 검색',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: editingController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset('assets/images/clear.svg'),
                      onPressed: () {
                        editingController.clear();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: primaryColor),
                        onPressed: () {
                          searchDisease(editingController.text);
                        },
                      ),
                    ),
                  ],
                ),
                hintText: "진단받은 병명",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: NextButton(
              onPressed: () {},
              buttonName: '완료',
              isButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
