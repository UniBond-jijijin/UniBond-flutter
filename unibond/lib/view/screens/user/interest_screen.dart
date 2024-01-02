import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/widgets/next_button.dart';
import 'package:unibond/view/widgets/selectable_container.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> selectedInterests = []; // 선택된 관심사 목록

  @override
  void initState() {
    super.initState();
    // Get.arguments를 사용하여 이전 화면에서 전달된 관심사 목록 받기
    selectedInterests = List<String>.from(Get.arguments ?? []);
    print(selectedInterests);
  }

  void handleSelection(bool isSelected, String interest) {
    setState(() {
      print(selectedInterests.length);
      print(selectedInterests);
      if (isSelected && !selectedInterests.contains(interest)) {
        selectedInterests.add(interest);
      } else if (!isSelected && selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      }
    });
  }

  bool isSelected(String interest) {
    // 관심사가 이미 선택된 상태인지 확인
    return selectedInterests.contains(interest);
  }

  void handleSubmit() {
    print("선택된 관심사: $selectedInterests");
    // 완료 버튼 클릭 시 로직
    if (selectedInterests.length >= 4) {
      print("선택된 관심사: $selectedInterests");
      _showResetDialog();
    } else {
      Get.back(result: selectedInterests);
    }
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('알림'),
          content: const Text('관심사는 최대 3개까지만 선택할 수 있습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  selectedInterests.clear(); // 배열 비우기
                });
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
        title: const Text(
          '관심사',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
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
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '최대 3개까지 선택 가능해요.',
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
                  SelectableContainer(
                    text: '임상시험',
                    isSelected: isSelected('임상시험'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '신약',
                    isSelected: isSelected('신약'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '신약'),
                  ),
                  SelectableContainer(
                    text: '치료제',
                    isSelected: isSelected('치료제'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '치료제'),
                  ),
                  SelectableContainer(
                    text: '영양',
                    isSelected: isSelected('영양'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '영양'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '유전자',
                    isSelected: isSelected('유전자'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '유전자'),
                  ),
                  SelectableContainer(
                    text: '수술',
                    isSelected: isSelected('수술'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '수술'),
                  ),
                  SelectableContainer(
                    text: '예후',
                    isSelected: isSelected('예후'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '예후'),
                  ),
                  SelectableContainer(
                    text: '병원',
                    isSelected: isSelected('병원'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '병원'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '보험',
                    isSelected: isSelected('보험'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '보험'),
                  ),
                  SelectableContainer(
                    text: '식단',
                    isSelected: isSelected('식단'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '식단'),
                  ),
                  SelectableContainer(
                    text: '복지',
                    isSelected: isSelected('복지'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '복지'),
                  ),
                  SelectableContainer(
                    text: '심리',
                    isSelected: isSelected('심리'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '심리'),
                  ),
                  SelectableContainer(
                    text: '의료비',
                    isSelected: isSelected('의료비'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '의료비'),
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
                  SelectableContainer(
                    text: '운동',
                    isSelected: isSelected('운동'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '운동'),
                  ),
                  SelectableContainer(
                    text: '문화생활',
                    isSelected: isSelected('문화생활'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '문화생활'),
                  ),
                  SelectableContainer(
                    text: '음악',
                    isSelected: isSelected('음악'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '음악'),
                  ),
                  SelectableContainer(
                    text: '아웃도어',
                    isSelected: isSelected('아웃도어'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '아웃도어'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '반려동물',
                    isSelected: isSelected('반려동물'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '반려동물'),
                  ),
                  SelectableContainer(
                    text: '영화,드라마',
                    isSelected: isSelected('영화,드라마'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '영화,드라마'),
                  ),
                  SelectableContainer(
                    text: '요리',
                    isSelected: isSelected('요리'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '요리'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '친목',
                    isSelected: isSelected('친목'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '친목'),
                  ),
                  SelectableContainer(
                    text: '환우회',
                    isSelected: isSelected('환우회'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '환우회'),
                  ),
                  SelectableContainer(
                    text: '이벤트',
                    isSelected: isSelected('이벤트'),
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '이벤트'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: NextButton(
                  onPressed: handleSubmit,
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
