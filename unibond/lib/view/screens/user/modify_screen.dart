import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/search_screen.dart';
import 'package:unibond/view/widgets/selected_button.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isPrivateSelected = false;

  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user_image.jpg',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    // color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '닉네임',
                              style: AskTextStyle,
                            ),
                            MyCustomTextFormField(
                              onChanged: (value) {},
                              maxLength: 5,
                              hintText: '자신의 닉네임을 입력해주세요!',
                            ),
                            const Text(
                              '한줄 소개',
                              style: AskTextStyle,
                            ),
                            MyCustomTextFormField(
                              onChanged: (value) {},
                              maxLength: 34,
                              hintText: '자기 자신을 간단하게 소개해주세요!',
                            ),
                            const Text(
                              '성별',
                              style: AskTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SignupEitherButton(
                                    text: '남',
                                    isSelected: isMaleSelected,
                                    onPressed: () {
                                      setState(() {
                                        isMaleSelected = true;
                                        isFemaleSelected = false;
                                        isPrivateSelected = false;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SignupEitherButton(
                                    text: '여',
                                    isSelected: isFemaleSelected,
                                    onPressed: () {
                                      setState(() {
                                        isFemaleSelected = true;
                                        isMaleSelected = false;
                                        isPrivateSelected = false;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SignupEitherButton(
                                    text: '비공개',
                                    isSelected: isPrivateSelected,
                                    onPressed: () {
                                      setState(() {
                                        isPrivateSelected = true;
                                        isMaleSelected = false;
                                        isFemaleSelected = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Text(
                '질환 정보',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '질환',
                                style: AskTextStyle,
                              ),
                              buildSearchRow(),
                              const Text(
                                '진단 시기',
                                style: AskTextStyle,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SignupEitherButton(
                                      text: '2000',
                                      isSelected: isMaleSelected,
                                      onPressed: () {
                                        setState(() {
                                          isMaleSelected = true;
                                          isFemaleSelected = false;
                                          isPrivateSelected = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SignupEitherButton(
                                      text: '01',
                                      isSelected: isFemaleSelected,
                                      onPressed: () {
                                        setState(() {
                                          isFemaleSelected = true;
                                          isMaleSelected = false;
                                          isPrivateSelected = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SignupEitherButton(
                                      text: '25',
                                      isSelected: isPrivateSelected,
                                      onPressed: () {
                                        setState(() {
                                          isPrivateSelected = true;
                                          isMaleSelected = false;
                                          isFemaleSelected = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final baseBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0.0,
    ),
    borderRadius: BorderRadius.circular(6.0),
  );
  Row buildSearchRow() {
    return Row(
      children: [
        Expanded(
            flex: 8,
            child: TextFormField(
              onChanged: (value) => {},
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                border: baseBorder,
                focusedBorder: baseBorder.copyWith(
                  borderSide: baseBorder.borderSide.copyWith(
                    color: primaryColor,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: primaryColor),
                  onPressed: () {
                    print("검색 버튼 클릭!");
                    Get.to(const SearchScreen());
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const SearchScreen(),
                    //   ),
                    // );
                  },
                ),
              ),
            )),
      ],
    );
  }
}
