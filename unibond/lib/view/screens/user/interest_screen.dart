import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/widgets/next_button.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> selectedInterests = []; // 선택된 관심사 목록
  static const int maxSelectedInterests = 4;

  @override
  void initState() {
    super.initState();
    // Get.arguments를 사용하여 이전 화면에서 전달된 관심사 목록 받기
    selectedInterests = List<String>.from(Get.arguments ?? []);
  }

  // 관심사를 선택하면 관심사 리스트에 추가 또는 삭제하기 위한 함수
  void handleSelection(bool isSelected, String interest) {
    setState(() {
      if (isSelected) {
        if (selectedInterests.length < maxSelectedInterests) {
          selectedInterests.add(interest);
        } else {
          _showResetDialog();
          return;
        }
      } else {
        selectedInterests.remove(interest);
      }
    });
  }

  bool isSelected(String interest) {
    // 관심사가 이미 선택된 상태인지 확인
    return selectedInterests.contains(interest);
  }

  void handleSubmit() {
    // Get.back을 사용하여 이전 화면으로 데이터를 반환하며 화면을 닫기
    Get.back(result: selectedInterests);
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('알림'),
          content: const Text(
            '관심사는 최대 4개까지만 선택할 수 있습니다.',
            style: notifyTextStyle,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 대화상자 닫기
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('관심사'),
        leading: Semantics(
          label: '뒤로 가기',
          child: ExcludeSemantics(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                '관심사를 알려주세요',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '최대 4개까지 선택할 수 있어요.',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '질환',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Semantics(
                    label: '인상시험',
                    child: createSelectableButton(
                      text: '임상시험',
                      isSelected: isSelected('임상시험'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '임상시험'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '신약',
                    child: createSelectableButton(
                      text: '신약',
                      isSelected: isSelected('신약'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '신약'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '치료제',
                    child: createSelectableButton(
                      text: '치료제',
                      isSelected: isSelected('치료제'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '치료제'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '영양',
                    child: createSelectableButton(
                      text: '영양',
                      isSelected: isSelected('영양'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '영양'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Semantics(
                    label: '유전자',
                    child: createSelectableButton(
                      text: '유전자',
                      isSelected: isSelected('유전자'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '유전자'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '수술',
                    child: createSelectableButton(
                      text: '수술',
                      isSelected: isSelected('수술'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '수술'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '예후',
                    child: createSelectableButton(
                      text: '예후',
                      isSelected: isSelected('예후'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '예후'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '병원',
                    child: createSelectableButton(
                      text: '병원',
                      isSelected: isSelected('병원'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '병원'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Semantics(
                    label: '보험',
                    child: createSelectableButton(
                      text: '보험',
                      isSelected: isSelected('보험'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '보험'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '식단',
                    child: createSelectableButton(
                      text: '식단',
                      isSelected: isSelected('식단'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '식단'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '복지',
                    child: createSelectableButton(
                      text: '복지',
                      isSelected: isSelected('복지'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '복지'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '심리',
                    child: createSelectableButton(
                      text: '심리',
                      isSelected: isSelected('심리'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '심리'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '의료비',
                    child: createSelectableButton(
                      text: '의료비',
                      isSelected: isSelected('의료비'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '의료비'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '일상',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Semantics(
                    label: '운동',
                    child: createSelectableButton(
                      text: '운동',
                      isSelected: isSelected('운동'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '운동'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '문화생활',
                    child: createSelectableButton(
                      text: '문화생활',
                      isSelected: isSelected('문화생활'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '문화생활'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '음악',
                    child: createSelectableButton(
                      text: '음악',
                      isSelected: isSelected('음악'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '음악'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '아웃도어',
                    child: createSelectableButton(
                      text: '아웃도어',
                      isSelected: isSelected('아웃도어'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '아웃도어'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Semantics(
                    label: '반려동물',
                    child: createSelectableButton(
                      text: '반려동물',
                      isSelected: isSelected('반려동물'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '반려동물'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '영화 드라마',
                    child: createSelectableButton(
                      text: '영화/드라마',
                      isSelected: isSelected('영화/드라마'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '영화/드라마'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '요리',
                    child: createSelectableButton(
                      text: '요리',
                      isSelected: isSelected('요리'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '요리'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Semantics(
                    label: '친목',
                    child: createSelectableButton(
                      text: '친목',
                      isSelected: isSelected('친목'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '친목'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '환우회',
                    child: createSelectableButton(
                      text: '환우회',
                      isSelected: isSelected('환우회'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '환우회'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                  Semantics(
                    label: '이벤트',
                    child: createSelectableButton(
                      text: '이벤트',
                      isSelected: isSelected('이벤트'),
                      onSelected: (isSelected) =>
                          handleSelection(isSelected, '이벤트'),
                      selectedInterests: selectedInterests,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Semantics(
                  label: '관심사 선택 완료',
                  child: NextButton(
                    onPressed: handleSubmit,
                    buttonName: '완료',
                    isButtonEnabled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createSelectableButton({
    required String text,
    required Function(bool isSelected) onSelected,
    bool isSelected = false,
    required List<String> selectedInterests,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              isSelected = !isSelected;
              onSelected(isSelected);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey,
                  width: 1,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
