import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/repository/members_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/user/modify_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<UserProfile>? userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = getMyProfile("29");
  }

  // bio 오버플로우 방지
  String processBioText(String bio) {
    if (bio.length > 20) {
      int periodIndex = bio.indexOf('.');
      if (periodIndex != -1 && periodIndex < 20) {
        return '${bio.substring(0, periodIndex + 1)}\n${bio.substring(periodIndex + 1)}';
      } else {
        return '${bio.substring(0, 20)}\n${bio.substring(20)}';
      }
    }
    return bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.50,
                ),
                const CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            UserProfile profile = snapshot.data!;
            return Column(
              children: [
                buildProfileHeader(context, profile),
                buildProfileBody(context, profile),
              ],
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      )),
    );
  }

  Widget buildProfileHeader(BuildContext context, UserProfile profile) {
    return Stack(
      children: [
        // 배경 컨테이너
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
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
            buildAppBar(context, profile),
            buildProfileInfo(context, profile),
            buildInterestTags(context, profile),
            // 질환 정보 및 진단 시기
            buildDiseaseInfo(context, profile),
          ],
        )
      ],
    );
  }

  AppBar buildAppBar(BuildContext context, UserProfile profile) {
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
            if (value == 'modify') {
              Get.to(() => const ModifyScreen(), arguments: profile.result);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'modify',
              child: Text('수정하기'),
            ),
          ],
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ],
    );
  }

  Widget buildProfileInfo(BuildContext context, UserProfile profile) {
    var userGender =
        convertGender(profile.result.gender.substring(0, 1).toUpperCase());
    String formattedBio = processBioText(profile.result.bio);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
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
                child: Text(
                  formattedBio,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
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

  Widget buildInterestTags(BuildContext context, UserProfile profile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: primaryColor),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Expanded(
              // 텍스트가 화면 너비를 초과하지 않도록 합니다.
              child: Text(
                profile.result.interestList.join(', '),
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

  Widget buildProfileBody(BuildContext context, UserProfile profile) {
    return Column(
      children: [
        // 활동 관리 및 기타 옵션들
        buildActivityOptions(context),
      ],
    );
  }

  Widget buildDiseaseInfo(BuildContext context, UserProfile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
      margin: const EdgeInsets.all(12),
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

  Widget buildActivityOptions(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            '활동 관리',
            style: TextStyle(color: borderColor),
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text('내가 올린 게시글'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('댓글 단 게시글'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('즐겨찾는 편지'),
          onTap: () {},
        ),
        Divider(color: Colors.grey[200], thickness: 8.0),
        ListTile(
          title: const Text(
            '기타',
            style: TextStyle(color: borderColor),
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            '사용설명서',
            style: titleTextStyle,
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            '고객센터',
            style: titleTextStyle,
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            '이용약관 및 정책',
            style: titleTextStyle,
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            '로그아웃',
            style: titleTextStyle,
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            '회원탈퇴',
            style: titleTextStyle,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
