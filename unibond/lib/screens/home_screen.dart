import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/screens/community/post_detail_screen.dart';
import 'package:unibond/screens/community/post_write_screen.dart';
import 'package:unibond/screens/letter/letter_box_screen.dart';
import 'package:unibond/screens/user/profile_screen.dart';
import 'package:unibond/widgets/navigator.dart';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: HomeScreen(),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("커뮤니티"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFCFDEFF), Color(0xFFE5C1FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 170,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7A34AC), Color(0xFF87ADFF)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              border: Border.all(
                                width: 5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "질문",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 120,
                            width: 170,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF6292), Color(0xFFFFF1DF)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              // border: Border.all(
                              //   width: 0,
                              // ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "경험기록",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      "질문 게시판",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => DetailScreen(id: index));
                        },
                        child: CustomListitem(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        // 현재 선택된 바텀 바 아이콘 인덱스
        currentIndex: 0,
        onTap: (index) {
          // 바텀 바 아이콘을 누를 때 화면 전환
          if (index == 0) {
            // 홈 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            //편지함 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LetterBoxScreen(
                        fakeEnvelopes: [
                          LetterEnvelope(date: '2023-10-15', sender: '지지진'),
                          LetterEnvelope(date: '2023-10-14', sender: '진지지'),
                        ],
                      )),
            );
          } else if (index == 2) {
            // 프로필 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => WriteScreen());
        },
        elevation: 4,
        label: const Text('글쓰기'),
        icon: const Icon(Icons.mode_edit_outlined),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.contentColorPink,
      ),
    );
  }
}

class PostsListView extends StatelessWidget {
  const PostsListView({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Get.to(() => DetailScreen(id: index));
              },
              child: CustomListitem(),
            ),
          ),
        );
      },
    );
  }
}

class CustomListitem extends StatelessWidget {
  const CustomListitem({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(child: Text('오지')),
          title: Row(
            children: [
              Text('지지진'),
              SizedBox(width: 3),
              Text('1일 전'),
            ],
          ),
          subtitle: Text("망막생소변성증"),
          isThreeLine: true,
        ),
        SizedBox(height: 0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "이것은 게시물의 내용입니다... 과연 어떤 게시물들이 올라올까요..기대가됩니다...",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
