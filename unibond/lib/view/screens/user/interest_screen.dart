import 'package:flutter/material.dart';
import 'package:unibond/view/widgets/next_button.dart';
import 'package:unibond/view/widgets/selectable_container.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> selectedInterests = []; // 선택된 관심사 목록

  void handleSelection(bool isSelected, String interest) {
    setState(() {
      if (isSelected) {
        // 관심사 추가
        selectedInterests.add(interest);
      } else {
        // 관심사 제거
        selectedInterests.remove(interest);
      }
    });
  }

  void handleSubmit() {
    // 완료 버튼 클릭 시 로직
    print("선택된 관심사: $selectedInterests");
    // 여기서 API 요청 등의 로직을 구현
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
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
                '최대 4개까지 중복으로 선택이 가능해요.',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
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
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '신약',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '치료제',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '영양',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '유전자',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '수술',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '예후',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '병원',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '보험',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '식단',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '복지',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '심리',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '의료비',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
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
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '문화생활',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '음악',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '아웃도어',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                ],
              ),
              Row(
                children: [
                  SelectableContainer(
                    text: '반려동물',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '영화,드라마',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                  SelectableContainer(
                    text: '요리',
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, '임상시험'),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
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
        ),
      ),
    );
  }
}
