import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/block_model.dart';
import 'package:unibond/model/other_user_profile.dart';
import 'package:unibond/repository/blocking_repository.dart';
import 'package:unibond/repository/letters_repository.dart';
import 'package:unibond/repository/members_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/calculate_days.dart';
import 'package:unibond/resources/confirm_dialog.dart';
import 'package:unibond/view/screens/community/post_detail_screen.dart';
import 'package:unibond/view/screens/letter/letter_write_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';

class OtherProfileScreen extends StatefulWidget {
  final int postOwnerId;
  const OtherProfileScreen({super.key, required this.postOwnerId});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  Future<OtherUserProfile>? userProfile;
  List<PostPreview>? postPreviewList;

  @override
  void initState() {
    super.initState();
  }

  // bio 오버플로우 방지
  String processBioText(String bio) {
    if (bio.length > 20) {
      int periodIndex = bio.indexOf('.');
      if (periodIndex != -1 && periodIndex < 20) {
        return '${bio.substring(0, periodIndex + 1)}\n${bio[periodIndex + 1] == ' ' ? bio.substring(periodIndex + 2) : bio.substring(periodIndex + 1)}';
      } else {
        return '${bio.substring(0, 20)}\n${bio.substring(20)}';
      }
    }
    return bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait(
            [getOtherProfile(widget.postOwnerId.toString()), getAuthToken()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                const CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text('다른 회원의 프로필을 불러올 수 없습니다.'));
          } else if (snapshot.hasData) {
            OtherUserProfile profile = snapshot.data![0] as OtherUserProfile;
            String myToken = snapshot.data![1] as String;

            postPreviewList = profile.result.postPreviewList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileHeader(
                    context, profile, myToken, profile.result.bio),
                const SizedBox(height: 8),
                Center(child: buildLetterSendButton(context)),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 4, 0, 4),
                  child: Text("게시물", style: primaryColorTextStyle20),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: postPreviewList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => DetailScreen(
                                  id: postPreviewList![index]
                                      .postId
                                      .toString()));
                            },
                            child: qnaCustomListItem(postPreviewList!, index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context, OtherUserProfile profile,
      String myToken, String bio) {
    return Stack(
      children: [
        // 배경 컨테이너
        Container(
          height: ((bio.length > 20))
              ? MediaQuery.of(context).size.height * 0.37
              : MediaQuery.of(context).size.height * 0.34,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFCFDEFF), Color(0xFFE5C1FF)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        // 프로필 정보 섹션
        Column(
          children: [
            buildAppBar(context, profile, myToken),
            buildProfileInfo(context, profile),
            buildInterestTags(context, profile),
            // 질환 정보 및 진단 시기
            buildDiseaseInfo(context, profile),
          ],
        )
      ],
    );
  }

  AppBar buildAppBar(
      BuildContext context, OtherUserProfile profile, String myToken) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
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
              showReportConfirmationDialog(context, '사용자를');
            } else if (value == 'block') {
              showBlockConfirmationDialog(
                  context, '사용자를', widget.postOwnerId, _handleBlockUser);
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
        ),
      ],
    );
  }

  Widget buildProfileInfo(BuildContext context, OtherUserProfile profile) {
    var userGender =
        convertGender(profile.result.gender.substring(0, 1).toUpperCase());
    String formattedBio = processBioText(profile.result.bio);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        // 프로필 사진
        ClipOval(
          child: profile.result.profileImage.isNotEmpty
              ? Image.network(
                  profile.result.profileImage,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/user_image.jpg',
                  width: 70,
                  height: 70,
                ),
        ),
        // 닉네임 및 성별 정보
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      profile.result.nickname,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        width: userGender == '비공개' ? 52 : 28,
                        height: 24,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: primaryColor, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            userGender,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(
                  width: 290,
                  child: Text(
                    formattedBio,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  String convertGender(String gender) {
    switch (gender.toUpperCase()) {
      case 'F':
        return '여';
      case 'M':
        return '남';
      default:
        return '비공개';
    }
  }

  Widget buildInterestTags(BuildContext context, OtherUserProfile profile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: primaryColor),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Expanded(
              // 텍스트가 화면 너비를 초과하지 않도록 합니다.
              child: Text(
                profile.result.interestList!.join(', '),
                overflow: TextOverflow.ellipsis, // 긴 텍스트를 축약합니다.
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDiseaseInfo(BuildContext context, OtherUserProfile profile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildInfoCard(title: '질환 정보', content: profile.result.diseaseName),
          buildInfoCard(
              title: '진단 시기', content: profile.result.diagnosisTiming),
        ],
      ),
    );
  }

  Widget buildInfoCard({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 170,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // 임시 overflow 처리
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                title,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 15),
              // overflow: TextOverflow.ellipsis,
              // maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLetterSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: ElevatedButton(
        onPressed: () {
          Get.to(() =>
              LetterWriteScreen(receiverId: widget.postOwnerId.toString()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 패딩
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Row의 크기를 내용에 맞게 조절
            children: [
              const Text('편지 보내기', style: coloredButtonTextStyle),
              const SizedBox(width: 12), // 텍스트와 아이콘 사이의 간격
              Image.asset(
                'assets/images/send.png',
                width: 24,
                height: 24,
              ), // 아이콘 추가
            ],
          ),
        ),
      ),
    );
  }

  // 사용자 차단시 실행되는 함수
  void _handleBlockUser(int userId) {
    BlockingUser blockingUser = BlockingUser(blockedMemberId: userId);
    blockUser(blockingUser).then((value) => Get.off(() => const RootTab()));
  }
}

Widget qnaCustomListItem(List<PostPreview> postPreviewList, int index) {
  var postDate = postPreviewList[index].createdDate;
  int daysDifference = calculatePassedDays(DateTime.parse(postDate));
  String boardType = postPreviewList[index].boardType;

  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipOval(
          child: postPreviewList[index].ownerProfileImg.isNotEmpty
              ? Image.network(
                  postPreviewList[index].ownerProfileImg,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  postPreviewList[index].ownerNick,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 12),
                Text(
                  '$daysDifference일 전',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                getFormattedBoardType(boardType),
                style: const TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        subtitle: Text(
          postPreviewList[index].disease,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 6),
        child: Text(
          postPreviewList[index].contentPreview,
          style: const TextStyle(
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}

String getFormattedBoardType(String boardType) {
  if (boardType == 'QNA') {
    return 'Q & A';
  } else if (boardType == 'EXPERIENCE') {
    return '경험 공유';
  } else {
    return boardType;
  }
}
