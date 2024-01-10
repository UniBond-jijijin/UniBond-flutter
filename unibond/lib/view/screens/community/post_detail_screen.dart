import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unibond/model/block_model.dart';
import 'package:unibond/model/post/comment_post.dart';
import 'package:unibond/model/post/qnapost_request.dart';
import 'package:unibond/repository/blocking_repository.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/repository/posts_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/confirm_dialog.dart';

import 'package:unibond/resources/modal_bottom_sheet.dart';
import 'package:unibond/view/screens/user/other_profile_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:unibond/view/screens/user/root_tab.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<QnaPostDetail>? qnaPostDetail;
  List<ParentComment> parentComments = [];
  Future<String>? myToken;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    qnaPostDetail = getQnaPostDetail(widget.id);
  }

  // 2개 함수 비동기 처리
  Future<QnaPostDetail> fetchQnaPosts() async {
    qnaPostDetail = getQnaPostDetail(widget.id);
    return qnaPostDetail!;
  }

  Future<String> fetchAuthToken() async {
    myToken = getAuthToken();
    return myToken!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Future.wait([fetchQnaPosts(), fetchAuthToken()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  // const CircularProgressIndicator(),
                ],
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              QnaPostDetail qnaPostDetail = snapshot.data![0] as QnaPostDetail;
              String myToken = snapshot.data![1] as String;

              parentComments = qnaPostDetail.result.parentCommentList!;

              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                            child: buildPost(context, qnaPostDetail,
                                myToken))), // 게시물+댓글 보는 영역
                    buildCommentPost(context, qnaPostDetail), // 댓글 다는 영역
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No data"));
            }
          },
        ),
      ),
    );
  }

  // 댓글 다는 영역
  Widget buildCommentPost(BuildContext context, QnaPostDetail qnaPostDetail) {
    return IconTheme(
      data: const IconThemeData(color: primaryColor),
      child: Container(
          // margin: const EdgeInsets.fromLTRB(12, 4, 8, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: primaryColor, width: 1), // 왼쪽 테두리
              top: BorderSide(color: primaryColor, width: 1), // 위쪽 테두리
              right: BorderSide(color: primaryColor, width: 1), // 오른쪽 테두리
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

  // 댓글 전송 완료시 실행되는 함수
  void _handleSubmitted(String text) {
    CommentPost comment = CommentPost(content: text);
    postComment(widget.id, comment).then((value) => setState(() {
          // 댓글 실시간 반영이 어려워서 GET -> POST -> GET으로 구현했음.
          qnaPostDetail = getQnaPostDetail(widget.id);
          _commentController.clear();
        }));
  }

// 게시물 부분
  Widget buildPost(
      BuildContext context, QnaPostDetail qnaPostDetail, String myToken) {
    return Stack(
      children: [
        Column(
          children: [
            buildAppBar(context, qnaPostDetail, myToken), // 앱바
            buildProfileInfo(context, qnaPostDetail, myToken), // 작성자 프로필
            buildPostContent(context, qnaPostDetail), // 글내용
            buildCommentContent(context, qnaPostDetail, myToken), // 댓글내용
          ],
        )
      ],
    );
  }

  AppBar buildAppBar(
      BuildContext context, QnaPostDetail qnaPostDetail, String myToken) {
    return AppBar(
      centerTitle: true,
      title: const Text('경험 공유'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        (myToken != qnaPostDetail.result.postOwnerId.toString())
            ? PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'report') {
                    showReportConfirmationDialog(context, '게시물을');
                  } else if (value == 'block') {
                    showBlockConfirmationDialog(context, '게시물을',
                        int.parse(widget.id), _handleBlockPost);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'report',
                    child: Text('신고하기'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'block',
                    child: Text('차단하기'),
                  ),
                ],
                icon: const Icon(Icons.more_vert, color: Colors.black),
              )
            : PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'delete') {
                    showDeleteConfirmationDialog(
                        context, '게시물을', widget.id, _handleDeletePost);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
  Widget buildProfileInfo(
      BuildContext context, QnaPostDetail qnaPostDetail, String myToken) {
    DateTime converToDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        .parse(qnaPostDetail.result.createdDate);

    return GestureDetector(
      onTap: () {
        // 다른 사람 프로필 조회
        if (myToken != qnaPostDetail.result.postOwnerId.toString()) {
          Get.to(() => OtherProfileScreen(
                postOwnerId: qnaPostDetail.result.postOwnerId,
              ));
        }
      },
      child: Padding(
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
          // 닉네임 및 질환 정보
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
                            timeago.format(converToDateTime, locale: "ko"),
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
      ),
    );
  }

// 글내용 부분
  Widget buildPostContent(BuildContext context, QnaPostDetail qnaPostDetail) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: SizedBox(
        width: double.infinity,
        child: Text(qnaPostDetail.result.content, style: contentTextStyle),
      ),
    );
  }

// 댓글내용 부분
  Widget buildCommentContent(
      BuildContext context, QnaPostDetail qnaPostDetail, String myToken) {
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
            Text(
                '댓글 ${qnaPostDetail.result.parentCommentPageInfo!.totalElements}개'),
            ListView.builder(
              reverse: true,
              padding: EdgeInsets.zero,
              itemCount: parentCommentList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var comment = parentCommentList[index];
                DateTime converToDateTime =
                    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                        .parse(comment.createdDate);

                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      // 다른 사람 프로필 조회
                      if (myToken != comment.commentUserId.toString()) {
                        Get.to(() => OtherProfileScreen(
                              postOwnerId: comment.commentUserId,
                            ));
                      }
                    },
                    child: ClipOval(
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
                  ),
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 다른 사람 프로필 조회
                          if (myToken != comment.commentUserId.toString()) {
                            Get.to(() => OtherProfileScreen(
                                  postOwnerId: comment.commentUserId,
                                ));
                          }
                        },
                        child: Text(
                          comment.commentUserName,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        timeago.format(converToDateTime, locale: "ko"),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  subtitle: Text(comment.content),
                  // 댓글 신고 및 삭제 기능
                  trailing: (myToken != comment.commentUserId.toString())
                      ? IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            showBlockBottomSheet(context, comment.commentId,
                                _handleBlockComment);
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            showDeleteBottomSheet(
                                context,
                                comment.commentUserId.toString(),
                                comment.commentId.toString(),
                                _handleDeleteComment);
                          },
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // 게시물 차단시 실행되는 함수
  void _handleBlockPost(int postId) {
    BlockingPost blockingPost = BlockingPost(blockedPostId: postId);
    blockPost(blockingPost).then((value) => Get.off(() => const RootTab()));
  }

  // 댓글 차단시 실행되는 함수
  void _handleBlockComment(int commentId) {
    BlockingComment blockingComment =
        BlockingComment(blockedCommentId: commentId);
    blockComment(blockingComment).then((value) => setState(() {
          qnaPostDetail = getQnaPostDetail(widget.id);
        }));
  }

  // 게시물 삭제시 실행되는 함수
  void _handleDeletePost(String postId) {
    delPost(postId).then((value) => Get.off(() => const RootTab()));
  }

  // 댓글 삭제시 실행되는 함수
  void _handleDeleteComment(String postId, String commentId) {
    delComment(postId, commentId).then((value) => setState(() {
          qnaPostDetail = getQnaPostDetail(widget.id);
        }));
  }
}
