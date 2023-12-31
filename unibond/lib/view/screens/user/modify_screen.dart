import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/interest_screen.dart';
import 'package:unibond/view/screens/user/search_screen.dart';
import 'package:unibond/view/widgets/next_button.dart';
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
  TextEditingController nicknameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  List<String> selectedInterests = []; // 선택된 관심사 목록

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  // 프로필 사진 등록
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // 닉네임 중복 확인
  void sendNicknameVerification() async {}

  // 질환 진단 시기 선택
  void _showDatePicker(BuildContext context) {}

  // 프로필 수정 완료 요청
  void updateMemberInfo() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: _image == null
                          ? Image.asset(
                              'assets/images/user_image.jpg',
                              width: 100,
                              height: 100,
                            )
                          : Image.file(
                              _image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.settings),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '닉네임',
                            style: AskTextStyle,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6, // 비율을 사용하여 width를 조절
                                child: MyCustomTextFormField(
                                  controller: nicknameController,
                                  hintText: '자신의 닉네임을 입력해주세요!',
                                  onChanged: (String value) {
                                    // checkEmailEnabled();
                                  },
                                  // errorText: emailErrorText,
                                ),
                              ),
                              const SizedBox(width: 10), // 텍스트 필드와 버튼 사이의 간격
                              Expanded(
                                flex: 3,
                                child: ElevatedButton(
                                  onPressed: sendNicknameVerification,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                  child: const Text(
                                    '중복 확인',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '한줄 소개',
                            style: AskTextStyle,
                          ),
                          MyCustomTextFormField(
                            controller: bioController,
                            onChanged: (value) {},
                            maxLength: 34,
                            maxLines: 4,
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
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Text(
                  '질환 정보',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '질환',
                            style: AskTextStyle,
                          ),
                          buildSearchRow(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '진단 시기',
                              style: AskTextStyle,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => _showDatePicker(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${selectedDate.year}',
                                    style: AskTextStyle,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '년',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () => _showDatePicker(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${selectedDate.month}',
                                    style: AskTextStyle,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '월',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () => _showDatePicker(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${selectedDate.day}',
                                    style: AskTextStyle,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '일',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '관심사',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          const InterestScreen(),
                        );
                      },
                      child: const Text(
                        '변경',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '질환',
                            style: AskTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: 400,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                // 텍스트를 컨테이너 중앙에 위치시킴
                                child: Text(
                                  '신약 / 치료제 / 영양 / 임상시험',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign:
                                      TextAlign.center, // 텍스트 정렬을 중앙으로 설정
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '일상',
                              style: AskTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: 400,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                // 텍스트를 컨테이너 중앙에 위치시킴
                                child: Text(
                                  '문화생활 / 반려동물 / 아웃도어 / 영화,...',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign:
                                      TextAlign.center, // 텍스트 정렬을 중앙으로 설정
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: NextButton(
                  onPressed: updateMemberInfo,
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
            minLines: 1,
            maxLines: 1,
            onChanged: (value) => {},
            controller: searchController,
            decoration: InputDecoration(
              fillColor: Colors.grey[50],
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 12), // 패딩 조정
              border: baseBorder,
              focusedBorder: baseBorder.copyWith(
                borderSide: baseBorder.borderSide.copyWith(
                  color: primaryColor,
                ),
              ),
              suffixIcon: Padding(
                // suffixIcon에 패딩 추가
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
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
            ),
          ),
        ),
      ],
    );
  }
}
