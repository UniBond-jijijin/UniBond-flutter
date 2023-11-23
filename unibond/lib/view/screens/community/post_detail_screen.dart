import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/size.dart';
import 'package:unibond/view/screens/community/post_update_screen.dart';
import 'package:unibond/view/screens/home_screen.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Comment> comments = [];
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('질문'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAll(() => const HomeScreen());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // TODO: 내 게시물/ 남의 게시물에 따라 다른 버튼 보이기
                          TextButton(
                              child: const Text(
                                '게시물 삭제',
                                style: TextStyle(fontSize: FontSize.menuName),
                              ),
                              onPressed: () {
                                Get.back();
                                _showDeleteConfirmationDialog(context);
                              }),
                          TextButton(
                              child: const Text(
                                '게시물 수정',
                                style: TextStyle(fontSize: FontSize.menuName),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Get.to(() => UpdateScreen());
                              }),
                          TextButton(
                              child: const Text(
                                '게시물 신고',
                                style: TextStyle(fontSize: FontSize.menuName),
                              ),
                              onPressed: () {
                                Get.back();
                                _showReportConfirmationDialog(context);
                              }),
                        ],
                      ),
                    ),
                  );
                },
              );
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
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$id번 댓글들이다!" * 40,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        for (var comment in comments)
                          CommentWidget(
                            author: comment.author,
                            comment: comment.comment,
                          ),
                      ],
                    ),
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
              // TextFormField 사용'padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: '댓글을 작성하세요',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      if (commentController.text.isNotEmpty) {
                        addComment();
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('게시물 삭제 확인'),
          content: const Text('이 게시물을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.off(() => const HomeScreen());
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

  void addComment() {
    setState(() {
      comments.add(
        Comment(
          author: '지지진',
          comment: commentController.text,
        ),
      );
      commentController.clear();
    });
  }
}

class Comment {
  final String author;
  final String comment;

  Comment({required this.author, required this.comment});
}

class CommentWidget extends StatelessWidget {
  final String author;
  final String comment;

  CommentWidget({required this.author, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$author 님의 댓글',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(comment),
        ],
      ),
    );
  }
}
