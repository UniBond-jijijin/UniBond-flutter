import 'package:flutter/material.dart';

void showReportConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '알림',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        content: const Text(
          '신고하시겠습니까?',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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

void showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('게시물 삭제 확인'),
        content: const Text('이 게시물을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              // Get.off(() => const HomeScreen());
              Navigator.of(context).pop();
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
