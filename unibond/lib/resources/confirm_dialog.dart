import 'package:flutter/material.dart';
import 'package:unibond/resources/toast.dart';

void showBlockConfirmationDialog(
    BuildContext context, String object, int id, Function(int) onBlockPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${object.substring(0, object.length - 1)} 차단 확인',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          '이 $object 차단하시겠습니까?\n차단 해제는 불가능합니다.',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onBlockPressed(id);
              Navigator.of(context).pop();
              showToastMessage('차단이 완료되었습니다.');
            },
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
}

void showDeleteLetterConfirmationDialog(
    BuildContext context, String object, int id, Function(int) onBlockPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${object.substring(0, object.length - 1)} 삭제 확인',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          '이 $object 삭제하시겠습니까?\n삭제 취소는 불가능합니다.',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onBlockPressed(id);
              Navigator.of(context).pop();
              showToastMessage('삭제이 완료되었습니다.');
            },
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
}

void showReportConfirmationDialog(BuildContext context, String object) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${object.substring(0, object.length - 1)} 신고 확인',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          '이 $object 신고하시겠습니까?',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showToastMessage('신고가 완료되었습니다.');
            },
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
}

void showDeleteConfirmationDialog(BuildContext context, String object,
    String id, Function(String) onDeletePressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${object.substring(0, object.length - 1)} 삭제 확인',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          '이 $object 삭제하시겠습니까?',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onDeletePressed(id);
              Navigator.of(context).pop();
              showToastMessage('삭제가 완료되었습니다.');
            },
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
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


// // 임시 스낵바 -> 작동 오류
// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: const Text('신고 완료되었습니다.'),
//     backgroundColor: Colors.white,
//     duration: const Duration(milliseconds: 1000),
//     behavior: SnackBarBehavior.floating,
//     action: SnackBarAction(
//       label: 'Undo',
//       textColor: primaryColor,
//       onPressed: () => print('Pressed'),
//     ),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//       side: const BorderSide(
//         color: primaryColor,
//         width: 2,
//       ),
//     ),
//   ),
// );
