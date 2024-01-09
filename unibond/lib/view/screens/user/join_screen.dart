import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/member_request.dart';
import 'package:unibond/repository/members_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/confirm_dialog.dart';
import 'package:unibond/util/auth_storage.dart';
import 'package:unibond/view/screens/user/interest_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/screens/user/search_screen.dart';
import 'package:unibond/view/widgets/next_button.dart';
import 'package:unibond/view/widgets/selected_button.dart';
import 'package:unibond/view/widgets/my_custom_text_form_field.dart';
// import 'package:dio/dio.dart' as dio; // Get Package와의 충돌 방지
import 'package:url_launcher/url_launcher.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  // String? _imageUrl; // 서버에서 받은 프로필 이미지 url 저장 변수
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController diseaseIdController = TextEditingController();
  TextEditingController diseaseTimingController = TextEditingController();

  int selectedDiseaseId = -1; // 선택된 질환 ID를 저장하는 변수
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isPrivateSelected = false;
  List<String> selectedInterests = [];
  DateTime selectedDate = DateTime.now();
  bool isPrivacyPolicyChecked = false;
  bool isTermsPolicyChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    passwordController.removeListener(_validateForm);
    passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _formKey.currentState?.validate();
    });
  }

  // 임시 비밀번호 유효성 검사 함수
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "값을 입력해주세요.";
    } else if (value.length < 6) {
      return "비밀번호의 최소 길이는 6자입니다.";
    } else if (value.length > 12) {
      return "비밀번호는 12자 이하로 입력해주세요.";
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return "적어도 하나의 숫자를 포함해야 합니다.";
    } else if (!RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return "적어도 하나의 특수문자를 포함해야 합니다.";
    }
    return null;
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

  // 회원가입 요청
  void createMemberInfo() async {
    try {
      String nickname = nicknameController.text.trim();
      String gender = isMaleSelected
          ? 'MALE'
          : isFemaleSelected
              ? 'FEMALE'
              : 'NULL';
      int diseaseId = selectedDiseaseId; // 질환 ID
      String diseaseTiming = selectedDate.toString(); // 진단 시기 -> 데이터 형식 맞추기
      String bio = bioController.text.trim(); // 한 줄 소개
      List<String> interestList = selectedInterests; // 관심사 목록

      var requestData = {
        "nickname": nickname,
        "gender": gender,
        "diseaseId": diseaseId,
        "diseaseTiming": diseaseTiming.split(" ")[0],
        "bio": bio,
        "interestList": interestList
      };

      MemberRequest request = MemberRequest.fromJson(requestData);
      var response = await createMember(request);

      if (response.code == 1000) {
        print("Profile created successfully.");

        // result 값을 Auth key로 저장하기
        // 임시 주석처리;
        // await AuthStorage.saveAuthToken(response.result.toString());
        await AuthStorage.saveAuthToken("29");
        Get.off(() => const RootTab());
      } else {
        if (response.code == 2502) {
          if (!mounted) return;
          // 중복입니다 다이얼로그
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
        }
        print("회원가입 Error : ${response.msg}");
      }
    } catch (e) {
      print("회원가입 Exception caught: $e");
    }
  }

  // Interest 받아오기
  Future<void> navigateAndHandleInterests() async {
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

  //개인정보 처리방침
  void _launchPrivacyPolicy() async {
    final Uri privacy = Uri.parse(
      'https://doc-hosting.flycricket.io/unibond-privacy-policy/f88dd207-dad1-4425-b2f2-d64c8070b93b/privacy',
    );
    if (await canLaunchUrl(privacy)) {
      await launchUrl(privacy);
    } else {
      throw 'Could not launch $privacy';
    }
  }

  void _launchTermsPolicy() async {
    final Uri terms = Uri.parse(
      'https://doc-hosting.flycricket.io/unibond-terms-of-use/fcd182e2-1c70-4d7b-bf1a-2684759dcae5/terms',
    );
    if (await canLaunchUrl(terms)) {
      await launchUrl(terms);
    } else {
      throw 'Could not launch $terms';
    }
  }

  void showSelectPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('주의'),
          content: const Text('개인정보 수집 및 이용에 동의하세요'),
          actions: [
            TextButton(
              onPressed: () {
                // Get.off(() => const HomeScreen());
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void showSelectTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('주의'),
          content: const Text('이용약관에 동의하세요'),
          actions: [
            TextButton(
              onPressed: () {
                // Get.off(() => const HomeScreen());
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
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
              '영화/드라마',
              '요리',
              '친목',
              '환우회',
              '이벤트'
            ].contains(interest))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('회원 가입'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
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
                              style: askTextStyle,
                            ),
                            MyCustomTextFormFieldWithNickname(
                              onChanged: (value) {},
                              controller: nicknameController,
                              hintText: '나만의 멋진 닉네임을 지어주세요',
                            ),
                            const Text(
                              '비밀번호',
                              style: askTextStyle,
                            ),
                            Form(
                              key: _formKey,
                              child: MyCustomTextFormField(
                                validator: _validatePassword,
                                controller: passwordController,
                                onChanged: (value) {},
                                maxLength: 12,
                                maxLines: 1,
                                obscureText: true,
                                hintText: '비밀번호를 입력해주세요',
                              ),
                            ),
                            const Text(
                              '한줄 소개',
                              style: askTextStyle,
                            ),
                            MyCustomTextFormField(
                              controller: bioController,
                              onChanged: (value) {},
                              maxLength: 34,
                              maxLines: 4,
                              hintText: '자기 자신을 간단하게 소개해주세요',
                            ),
                            const Text(
                              '성별',
                              style: askTextStyle,
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
                              style: askTextStyle,
                            ),
                            const SizedBox(height: 8),
                            buildSearchRow(),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '진단 시기',
                                style: askTextStyle,
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
                                      style: askTextStyle,
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
                                      style: askTextStyle,
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
                                      style: askTextStyle,
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
                          '등록',
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
                              style: askTextStyle,
                            ),
                            InkWell(
                              onTap: navigateAndHandleInterests,
                              child: Padding(
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
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '일상',
                                style: askTextStyle,
                              ),
                            ),
                            InkWell(
                              onTap: navigateAndHandleInterests,
                              child: Padding(
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
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isPrivacyPolicyChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPrivacyPolicyChecked = value ?? false;
                                    });

                                    if (!isPrivacyPolicyChecked) {
                                      showSelectPrivacyDialog(context);
                                      setState(() {
                                        isPrivacyPolicyChecked = false;
                                      });
                                    }
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    '개인정보 수집 및 이용동의(필수)',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _launchPrivacyPolicy,
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isTermsPolicyChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isTermsPolicyChecked = value ?? false;
                                    });

                                    if (!isTermsPolicyChecked) {
                                      showSelectTermsDialog(context);
                                      setState(() {
                                        isTermsPolicyChecked = false;
                                      });
                                    }
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    '이용약관 동의(필수)',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _launchTermsPolicy,
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: NextButton(
                    onPressed: createMemberInfo,
                    buttonName: '완료',
                    isButtonEnabled: true,
                  ),
                ),
              ],
            ),
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
            readOnly: true,
            minLines: 1,
            maxLines: 1,
            onChanged: (value) => {},
            controller: searchController,
            decoration: InputDecoration(
              hintText: "오른쪽 돋보기 아이콘을 터치해주세요.",
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
                  onPressed: () async {
                    // SearchScreen 이동 후 선택된 데이터를 기다림.
                    final selectedData = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                    if (selectedData != null) {
                      setState(() {
                        searchController.text = selectedData['diseaseNameKor'];
                        selectedDiseaseId = selectedData["diseaseId"];
                      });
                    }
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
