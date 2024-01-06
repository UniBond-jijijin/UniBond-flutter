import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unibond/model/other_user_profile.dart';
import 'package:unibond/repository/members_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/modify_screen.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  Future<OtherUserProfile>? userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = getOtherProfile("30");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<OtherUserProfile>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("에러 발생: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              OtherUserProfile profile = snapshot.data!;
              return Column(
                children: [
                  buildProfileHeader(context, profile),
                  buildProfileBody(context, profile),
                ],
              );
            } else {
              return const Center(child: Text("데이터가 없습니다."));
            }
          },
        ),
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context, OtherUserProfile profile) {
    return Stack(
      children: [
        // 배경 컨테이너
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
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
        // 프로필 섹션
        Column(
          children: [
            buildAppBar(context, profile),
            buildProfileInfo(context, profile),
            buildInterestTags(context, profile),
          ],
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context, OtherUserProfile profile) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '내 프로필',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'report') {
              Get.to(() => const ModifyScreen(), arguments: profile.result);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'report',
              child: Text('신고하기'),
            ),
          ],
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ],
    );
  }

  Widget buildProfileInfo(BuildContext context, OtherUserProfile profile) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          // 프로필 이미지
          ClipOval(
            child: profile.result.profileImage.isNotEmpty
                ? Image.network(
                    profile.result.profileImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover, // 이미지가 주어진 크기에 맞춰 조정
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          width: 31,
                          height: 25,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryColor, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              profile.result.gender
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    profile.result.bio,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInterestTags(BuildContext context, OtherUserProfile profile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: primaryColor),
          Expanded(
            // 텍스트가 화면 너비를 초과하지 않도록 합니다.
            child: Text(
              profile.result.interestList?.join(', ') ?? '없음',
              overflow: TextOverflow.ellipsis, // 긴 텍스트를 축약합니다.
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileBody(BuildContext context, OtherUserProfile profile) {
    return Column(
      children: [
        // 질환 정보 및 진단 시기
        buildDiseaseInfo(context, profile),
      ],
    );
  }

  Widget buildDiseaseInfo(BuildContext context, OtherUserProfile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildInfoCard(title: '질환정보', content: profile.result.diseaseName),
          buildInfoCard(
              title: '진단 시기', content: profile.result.diagnosisTiming),
        ],
      ),
    );
  }

  Widget buildInfoCard({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: 160,
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
