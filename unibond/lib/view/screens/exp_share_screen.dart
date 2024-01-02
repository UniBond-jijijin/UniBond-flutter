import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/post_controller.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/view/screens/community/post_detail_screen.dart';
import 'package:unibond/view/screens/community/post_write_screen.dart';

class ExpShareScreen extends StatefulWidget {
  const ExpShareScreen({super.key});

  @override
  State<ExpShareScreen> createState() => _ExpShareScreenState();
}

class _ExpShareScreenState extends State<ExpShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'UniBond',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: buildMenuHeader(context),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 0, 10),
                    child: Text(
                      "질문 게시판",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: PostsListView()),
                ],
              ),
            ),
          ),
        ],
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

Widget buildMenuHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Get.to(() => const ExpShareScreen());
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
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
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Q & A", style: homeMenuTextStyle),
              ),
              Align(
                alignment: const Alignment(2.0, 2.0),
                child: Image.asset(
                  'assets/images/qna_community_design.png',
                  width: 140,
                  // 이미지의 다른 속성들 설정
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 20),
      GestureDetector(
        onTap: () {
          Get.to(() => const ExpShareScreen());
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 120,
          width: 170,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6292), Color(0xFFFFF1DF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("경험 공유", style: homeMenuTextStyle),
              ),
              Align(
                alignment: const Alignment(1.5, 1.5),
                child: Image.asset(
                  'assets/images/exp_community_design.png',
                  width: 140,
                  // 이미지의 다른 속성들 설정
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class PostsListView extends StatelessWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    PostController p = Get.put(PostController());

    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: p.posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Get.to(() => DetailScreen(id: index));
                },
                child: MyCustomListItem(p, index),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget MyCustomListItem(PostController p, int index) {
  var postDate = p.posts[index].createdDate;
  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(postDate!);
  int daysDifference = difference.inDays;

  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipOval(
          child: p.posts[index].ownerProfileImg!.isNotEmpty
              ? Image.network(
                  p.posts[index].ownerProfileImg!,
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
          children: [
            Text(
              p.posts[index].ownerNick!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 12),
            Text(
              '$daysDifference일 전',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        subtitle: Text(
          p.posts[index].disease!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 6),
        child: Text(
          p.posts[index].contentPreview!,
          style: const TextStyle(
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}
