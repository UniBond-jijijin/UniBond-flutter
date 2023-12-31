import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
import 'package:unibond/view/screens/user/modify_screen.dart';
import 'package:unibond/view/widgets/navigator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFCFDEFF), // CFDEFF 색상
                        Color(0xFFE5C1FF), // E5C1FF 색상
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30), // 아래쪽 왼쪽 모서리 둥글게
                      bottomRight: Radius.circular(30), // 아래쪽 오른쪽 모서리 둥글게
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent, // 투명 배경
                      elevation: 0, // 그림자 제거
                      title: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '내 프로필',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      actions: [
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            switch (value) {
                              case 'modify':
                                Get.to(const ModifyScreen());
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'modify',
                              child: Text('수정하기'),
                            ),
                          ],
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/user_image.jpg',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      const Text(
                                        '지지진',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Container(
                                          width: 31,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: primaryColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '여',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '안녕하세요000입니다!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 25, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: primaryColor,
                          ),
                          Text(
                            '신약,치료제,영양,임상시험,문화생활,음악,아웃도어',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(12),
                          width: 170,
                          height: 80,
                          padding: const EdgeInsets.all(16),
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '질환 정보',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '망막색소변성증',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(12),
                          width: 170,
                          height: 80,
                          padding: const EdgeInsets.all(16),
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '진단 시기',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '2001.01.25',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //   Positioned(
                //     top: 220,
                //     left: 0,
                //     right: 0,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           margin: const EdgeInsets.all(12),
                //           width: 150,
                //           height: 70,
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: const Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(3),
                //                 child: Text(
                //                   '질환정보',
                //                   style: TextStyle(
                //                     fontSize: 13,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //               ),
                //               Text(
                //                 '망막색소변성증',
                //                 style: TextStyle(
                //                   fontSize: 13,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.all(20),
                //           width: 150,
                //           height: 70,
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: const Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(3),
                //                 child: Text(
                //                   '진단 시기',
                //                   style: TextStyle(
                //                     fontSize: 13,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //               ),
                //               Text(
                //                 '2001.01.25',
                //                 style: TextStyle(
                //                   fontSize: 13,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //
              ],
            ),
            const SizedBox(
              height: 20,
            ),
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
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LetterBoxScreen(
                  fakeEnvelopes: [
                    LetterEnvelope(date: '2023-10-15', sender: '지지진'),
                    LetterEnvelope(date: '2023-10-14', sender: '진지지'),
                  ],
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
