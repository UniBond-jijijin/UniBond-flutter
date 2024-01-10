import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/widgets/next_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  Timer? debouncer;
  List<dynamic> searchResults = []; // 검색 결과를 저장하는 리스트
  dynamic selectedData; // 선택된 질환명 데이터를 저장하는 변수
  int selectedCellIndex = -1; // 선택된 셀의 인덱스를 저장하는 변수

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
    editingController.dispose();
    super.dispose();
  }

  // 질병 검색 API 호출
  Future<void> searchDisease(String query) async {
    debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 1000), () async {
      try {
        final dio = Dio();
        var response = await dio.get(
            'http://3.35.110.214/api/v1/diseases/search',
            queryParameters: {'lan': 'kor', 'query': query, 'page': 0});
        if (response.statusCode == 200 && response.data['isSuccess']) {
          setState(() {
            searchResults = response.data['result']['diseaseDataList'];
          });
        }
      } catch (err) {
        rethrow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('질환 검색'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
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
                        padding: const EdgeInsets.only(right: 2),
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    var disease = searchResults[index];
                    return ListTile(
                      title: Text(disease['diseaseNameKor']),
                      subtitle: Text(disease['diseaseNameEng']),
                      textColor: selectedCellIndex == index
                          ? Colors.white
                          : Colors.black,
                      tileColor:
                          selectedCellIndex == index ? primaryColor : null,
                      onTap: () {
                        setState(() {
                          // 이전에 선택된 셀의 선택 상태를 해제하고 현재 선택한 셀의 선택 상태로 지정
                          if (selectedCellIndex != -1) {
                            selectedCellIndex = -1;
                          }
                          if (selectedCellIndex != index) {
                            selectedCellIndex = index;
                            selectedData =
                                disease; // 선택한 질환명 데이터를 selectedData에 저장
                          } else {
                            selectedData = null; // 같은 셀을 다시 탭하면 선택 해제
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: NextButton(
                  onPressed: () {
                    if (selectedData != null) {
                      Navigator.of(context)
                          .pop(selectedData); // 선택한 데이터를 ModifyScreen으로 전송
                    }
                  },
                  buttonName: '완료',
                  isButtonEnabled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
