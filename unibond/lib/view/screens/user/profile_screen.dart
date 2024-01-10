import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/model/post/withdraw_dto.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/repository/members_repository.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/toast.dart';
import 'package:unibond/util/auth_storage.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/view/screens/user/modify_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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

    AuthStorage.getAuthToken().then((String? authToken) {
      if (authToken != null) {
        setState(() {
          userProfile = getMyProfile(authToken);
        });
      } else {
        // authToken이 null인 경우의 처리
        print("authToken 없음");
      }
    });
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
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
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
            return Center(child: Text('내 프로필 스냅샷 Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            UserProfile profile = snapshot.data!;
            return Column(
              children: [
                buildProfileHeader(context, profile),
                buildActivityOptions(context),
              ],
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
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
    final Uri terms = Uri.parse(
      'https://doc-hosting.flycricket.io/unibond-terms-of-use/fcd182e2-1c70-4d7b-bf1a-2684759dcae5/terms',
    );
    final Uri privacy = Uri.parse(
      'https://doc-hosting.flycricket.io/unibond-privacy-policy/f88dd207-dad1-4425-b2f2-d64c8070b93b/privacy',
    );
    return Expanded(
      child: ListView(
        children: [
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(16, 24, 0, 8),
          //   child: Text(
          //     '활동 관리',
          //     style: TextStyle(color: borderColor),
          //   ),
          // ),
          // ListTile(
          //   title: const Text('내가 올린 게시글'),
          //   onTap: () {
          //     showToastMessage("업데이트 준비중인 기능입니다.");
          //   },
          // ),
          // ListTile(
          //   title: const Text('댓글 단 게시글'),
          //   onTap: () {
          //     showToastMessage("업데이트 준비중인 기능입니다.");
          //   },
          // ),
          // ListTile(
          //   title: const Text('즐겨찾는 편지'),
          //   onTap: () {
          //     showToastMessage("업데이트 준비중인 기능입니다.");
          //   },
          // ),
          // Divider(color: Colors.grey[200], thickness: 4.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Text(
              '서비스 정보',
              style: TextStyle(color: borderColor),
            ),
          ),
          ListTile(
            title: const Text(
              '이용약관 및 정책',
              style: titleTextStyle16,
            ),
            onTap: () async {
              if (await canLaunchUrl(terms)) {
                launchUrl(terms);
              } else {
                print("Can't launch $terms");
              }
            },
          ),
          ListTile(
            title: const Text(
              '서비스 이용방법',
              style: titleTextStyle16,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              '개인정보 처리방침',
              style: titleTextStyle16,
            ),
            onTap: () async {
              if (await canLaunchUrl(privacy)) {
                launchUrl(privacy);
              } else {
                print("Can't launch $privacy");
              }
            },
          ),
          Divider(color: Colors.grey[200], thickness: 4.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              '도움말 및 기타',
              style: TextStyle(color: borderColor),
            ),
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '고객센터',
                  style: titleTextStyle16,
                ),
                Text(
                  'unibond34@gmail.com',
                  style: greyTitleTextStyle,
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '버전 정보',
                  style: titleTextStyle16,
                ),
                Text(
                  '1.0.0',
                  style: greyTitleTextStyle,
                ),
              ],
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey[200], thickness: 4.0),
          Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: TextButton(
                  onPressed: () {
                    showWithdrawConfirmationDialog();
                  },
                  child: const Text(
                    '회원 탈퇴',
                    style: TextStyle(color: borderColor),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void showWithdrawConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '회원 탈퇴 확인',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            '정말로 회원을 탈퇴하시겠습니까?',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                withdrawUser();
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void withdrawUser() async {
    AuthStorage.getAuthToken().then((String? authToken) {
      if (authToken != null) {
        final userId = authToken; // Replace with the actual user ID
        WithdrawRepository().withdrawUser(userId).then((WithdrawDto dto) {
          if (dto.isSuccess) {
            showToastMessage("회원탈퇴 완료");
            Get.offAll(() => const JoinScreen());
          } else {
            // Handle unsuccessful withdrawal
            showToastMessage(dto.message);
          }
        }).catchError((error) {
          // Handle Dio errors or other exceptions
          showToastMessage("회원 탈퇴 중 오류가 발생했습니다.");
        });
      }
    });
  }
}
