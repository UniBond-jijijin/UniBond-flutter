import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('질문'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showReportConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 게시물 영역
                  Container(
                    width: double.infinity,
                    color: Colors.amber,
                    // TODO: 게시물 영역 UI 구성
                    // 사용자 기본정보 영역, 게시글 내용 영역 등을 구성
                    child: Text("$id번 게시물 상세 내용이다!" * 50),
                  ),
                  // 댓글 확인 영역
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    // TODO: 작성된 댓글 영역 구현
                    // ListView.builder 사용
                    // 각 댓글은 사용자 기본정보, 댓글 내용, 대댓글 및 삭제 버튼으로 구성
                    // 스크롤 가능한 영역임: SingleChildScrollView or ListView 활용
                    child: Text("$id번 댓글들이다!" * 40),
                  ),
                ],
              ),
            ),
          ),
          // 댓글 작성 영역
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.purple,
              // TODO: 댓글 작성 UI 및 기능 구현
              // TextFormField 사용
            ),
          ),
        ],
      ),
    );
  }

  void _showReportConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('게시물 신고 확인'),
          content: const Text('이 게시물을 신고하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
