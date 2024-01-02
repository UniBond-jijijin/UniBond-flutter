import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/util/url.dart';
import 'package:unibond/view/screens/user/interest_screen.dart';
import 'package:unibond/view/screens/user/search_screen.dart';
import 'package:unibond/view/widgets/next_button.dart';
import 'package:unibond/view/widgets/selected_button.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';

import 'package:dio/dio.dart' as dio; // Get Package와의 충돌 방지

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isPrivateSelected = false;
  String? _imageUrl; // 서버에서 받은 프로필 이미지 url 저장 변수

  TextEditingController searchController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // 선택된 관심사 목록
  List<String> selectedInterests = [];

  // 프로필 사진
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final UserProfileResult profile = Get.arguments;
    _imageUrl = profile.profileImage; // 이미지 URL 초기화
    nicknameController.text = profile.nickname;
    bioController.text = profile.bio;
    searchController.text = profile.diseaseName;
    // 성별에 따른 선택 상태 초기화
    isMaleSelected = profile.gender == "MALE";
    isFemaleSelected = profile.gender == "FEMALE";
    isPrivateSelected = profile.gender == "NULL" || profile.gender.isEmpty;
    // 관심사 목록 초기화
    selectedInterests = List<String>.from(profile.interestList);
    // 진단 시기 초기화
    selectedDate = DateTime.parse(profile.diagnosisTiming);
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageUrl = null; // 새 이미지를 선택했으므로 기존 프로필사진 url은 초기화한다.
      } else {
        print('No image selected.');
      }
    });
  }

  // 질환 진단 시기 선택
  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    selectedDate = val;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 프로필 수정 완료 요청
  void updateMemberInfo() async {
    try {
      String nickname = nicknameController.text.trim();
      String gender = isMaleSelected
          ? 'MALE'
          : isFemaleSelected
              ? 'FEMALE'
              : 'NULL';
      String diseaseId = "3"; // 질환 ID
      String diagnosisTiming = selectedDate.toString(); // 진단 시기
      String bio = bioController.text.trim(); // 한 줄 소개
      List<String> interestList = selectedInterests; // 관심사 목록

      var dioClient = dio.Dio();
      var requestData = {
        "nickname": nickname,
        "gender": gender,
        "diseaseId": diseaseId,
        "diagnosisTiming": diagnosisTiming,
        "bio": bio,
        "interestList": interestList
      };

      // 미완성 formData
      dio.FormData formData = dio.FormData.fromMap({
        "request": requestData // 'request' key에 JSON 데이터 할당
      });

      var response = await dioClient.patch(
        '$ip/api/v1/members/29',
        options: dio.Options(headers: {'Authorization': '29'}),
        data: formData,
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully.");
      } else {
        print("Error updating profile: ${response.data}");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  Future<void> navigateAndHandleInterests() async {
    // InterestScreen으로 이동하고 결과를 기다립니다.
    final result = await Get.to(
      () => const InterestScreen(),
      arguments: selectedInterests,
    );

    // 결과가 List<String> 형태로 반환되었을 경우, 관심사 목록을 업데이트합니다.
    if (result != null && result is List<String>) {
      setState(() {
        selectedInterests = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 질환 관련 관심사 필터링
    List<String> diseaseInterests = selectedInterests
        .where((interest) => [
              '임상시험',
              '신약',
              '치료제',
              '영양',
              '유전자',
              '수술',
              '예후',
              '병원',
              '보험',
              '식단',
              '복지',
              '심리',
              '의료비'
            ].contains(interest))
        .toList();

    // 일상 관련 관심사 필터링
    List<String> dailyInterests = selectedInterests
        .where((interest) => [
              '운동',
              '문화생활',
              '음악',
              '아웃도어',
              '반려동물',
              '영화,드라마',
              '요리',
              '친목',
              '환우회',
              '이벤트'
            ].contains(interest))
        .toList();

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
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : (_imageUrl != null
                              ? Image.network(
                                  _imageUrl!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/user_image.jpg', // 기본 이미지
                                  width: 100,
                                  height: 100,
                                )),
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
                          MyCustomTextFormFieldWithNickname(
                            onChanged: (value) {},
                            controller: nicknameController,
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
                                    color: Colors.grey[100],
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
                                    color: Colors.grey[100],
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
                                    color: Colors.grey[100],
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
                      onTap: navigateAndHandleInterests,
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
                                child: Text(
                                  diseaseInterests.join(' / '),
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
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
                                child: Text(
                                  dailyInterests.join(' / '),
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
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
      width: 1.0,
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
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6.0),
              ),
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
                    Get.to(() => const SearchScreen());
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
