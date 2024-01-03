import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unibond/model/post/qnapost_request.dart';
import 'package:unibond/repository/posts_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/calculateDays.dart';
import 'package:unibond/resources/confirm_dialog.dart';
import 'package:unibond/view/screens/qna_home_screen.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<QnaPostDetail>? qnaPostDetail;

  List<Comment> comments = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    qnaPostDetail = getPostDetail(widget.id, "29");
    // qnaPostDetail = getPostDetail(widget.id.toString(), "29");
    // 테스트용'60', real postId로 변경 필요함(preview단에서 단순 item 길이를 index로 써두고 그걸 postId로 취급했는데, 그게아니라 홈에서도 통신을 해서 postId값을 뽑아내고 그걸 arg로 넘겨주는식으로 리팩터링ㄱㄱ)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: qnaPostDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                const CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            /// future형 qnaPostDetail은 futurebuilder를 통해서 데이터를 받아오기 위한 놈이고, 아래 저놈은 실제 받아온 데이터를 활용하기 위한 변수임.
            QnaPostDetail qnaPostDetail = snapshot.data!;
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                          child: buildPost(
                              context, qnaPostDetail))), // 게시물+댓글 보는 영역
                  buildCommentPost(context, qnaPostDetail), // 댓글 다는 영역
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }

  void addComment() {}

  Widget buildCommentPost(BuildContext context, QnaPostDetail qnaPostDetail) {
    return IconTheme(
      data: const IconThemeData(color: primaryColor),
      child: Container(
          // margin: const EdgeInsets.fromLTRB(12, 4, 8, 24),
          decoration: const BoxDecoration(
            color: Colors.white, // 내부 색상을 정합니다.
            border: Border(
              left: BorderSide(color: primaryColor, width: 1), // 왼쪽 테두리
              top: BorderSide(color: primaryColor, width: 1), // 위쪽 테두리
              right: BorderSide(color: primaryColor, width: 1), // 오른쪽 테두리
              // bottom 테두리는 정의하지 않음
            ),

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 20, 4),
                  child: ClipOval(
                    child:
                        qnaPostDetail.result.loginMemberProfileImage.isNotEmpty
                            ? Image.network(
                                qnaPostDetail.result.loginMemberProfileImage,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/user_image.jpg',
                                width: 42,
                                height: 42,
                              ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _commentController,
                    onSubmitted: _handleSubmitted,
                    decoration:
                        const InputDecoration.collapsed(hintText: "댓글을 입력하세요"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () =>
                          _handleSubmitted(_commentController.text)),
                ),
              ],
            ),
          )),
    );
  }

  void _handleSubmitted(String text) {
    _commentController.clear();
    setState(() {
      // 여기서 서버통신; 보내고
      comments.add(
        Comment(
          author: '지지진',
          comment: _commentController.text,
        ),
      );
      _commentController.clear();
    });
  }
}

// 게시물 부분
Widget buildPost(BuildContext context, QnaPostDetail qnaPostDetail) {
  return Stack(
    children: [
      Column(
        children: [
          buildAppBar(context, qnaPostDetail), // 앱바
          buildProfileInfo(context, qnaPostDetail), // 작성자 프로필
          buildPostContent(context, qnaPostDetail), // 글내용
          buildCommentContent(context, qnaPostDetail), // 댓글내용
        ],
      )
    ],
  );
}

AppBar buildAppBar(BuildContext context, QnaPostDetail qnaPostDetail) {
  return AppBar(
    centerTitle: true,
    title: const Text('질문'),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Get.back();
      },
    ),
    actions: [
      PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == 'report') {
            showReportConfirmationDialog(context);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'report',
            child: Text('신고하기'),
          ),
          const PopupMenuItem<String>(
            value: 'modify',
            child: Text('수정하기'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('삭제하기'),
          ),
        ],
        icon: const Icon(Icons.more_vert, color: Colors.black),
      ),
    ],
  );
}

// 작성자 프로필 부분
Widget buildProfileInfo(BuildContext context, QnaPostDetail qnaPostDetail) {
  DateTime converToDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
      .parse(qnaPostDetail.result.createdDate);
  int passedDays = calculatePassedDays(converToDateTime);

  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(children: [
      // 프로필 사진
      ClipOval(
        child: qnaPostDetail.result.profileImage.isNotEmpty
            ? Image.network(
                qnaPostDetail.result.profileImage,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/user_image.jpg',
                width: 50,
                height: 50,
              ),
      ),
      // 닉네임 및 성별 정보
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    qnaPostDetail.result.postOwnerName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Center(
                      child: Text(
                        "$passedDays일 전",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 25, 25, 25),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                qnaPostDetail.result.diseaseName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}

// 글내용 부분
Widget buildPostContent(BuildContext context, QnaPostDetail qnaPostDetail) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
    child: SizedBox(
      width: double.infinity,
      child: Text(qnaPostDetail.result.content),
    ),
  );
}

// 댓글내용 부분
Widget buildCommentContent(BuildContext context, QnaPostDetail qnaPostDetail) {
  DateTime converToDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
      .parse(qnaPostDetail.result.createdDate);
  int passedDays = calculatePassedDays(converToDateTime);

  List<ParentComment> parentCommentList =
      qnaPostDetail.result.parentCommentList!;

  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.grey, thickness: 1.0),
          const SizedBox(
            height: 8,
          ),
          Text('댓글 ${qnaPostDetail.result.commentCount}개'),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: parentCommentList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var comment = parentCommentList[index];
              return Container(
                child: ListTile(
                  leading: ClipOval(
                    child: comment.profileImgUrl.isNotEmpty
                        ? Image.network(
                            comment.profileImgUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/user_image.jpg',
                            width: 40,
                            height: 40,
                          ),
                  ),
                  title: Row(
                    children: [
                      Text(comment.commentUserName),
                      const SizedBox(width: 12),
                      Text(
                        '$passedDays일 전',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 25, 25, 25),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  subtitle: Text(comment.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.report_gmailerrorred), // 신고 아이콘
                    onPressed: () {
                      showReportConfirmationDialog(context);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
  );
}

class Comment {
  final String author;
  final String comment;

  Comment({required this.author, required this.comment});
}

class CommentWidget extends StatelessWidget {
  final String author;
  final String comment;

  const CommentWidget({super.key, required this.author, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$author 님의 댓글',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(comment),
        ],
      ),
    );
  }
}
