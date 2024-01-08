import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/exppost_controller.dart';
import 'package:unibond/controller/qnapost_controller.dart';
import 'package:unibond/model/post/exppost_prev.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/calculateDays.dart';
import 'package:unibond/view/screens/community/exppost_write_screen.dart';
import 'package:unibond/view/screens/community/post_detail_screen.dart';
import 'package:unibond/view/screens/community/qnapost_write_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMenuIndex = 0;
  Future<ExpPostPrevRequest>? expPostPrevRequest;

  @override
  void initState() {
    super.initState();
  }

  Widget qnaMenu() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenuIndex = 0;
        });
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
            width: selectedMenuIndex == 0 ? 5 : 0,
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
    );
  }

  Widget expMenu() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenuIndex = 1;
        });
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
          border: Border.all(
            width: selectedMenuIndex == 1 ? 5 : 0,
            color: Colors.white,
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
              alignment: const Alignment(1.7, 1.3),
              child: Image.asset(
                'assets/images/exp_community_design.png',
                width: 140,
                // 이미지의 다른 속성들 설정
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostContent() {
    if (selectedMenuIndex == 0) {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "❓ 궁금한 것을 물어보세요!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "        유니본드 친구들이 대답해줄 거예요.💬",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 85, 85, 85),
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            Expanded(child: QnaPostsListView()),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔗 서로의 경험을 공유해봐요",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "        생각지도 못한 꿀팁을 얻을수도 있잖아요👀",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 85, 85, 85),
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            Expanded(child: ExpPostsListView()),
          ],
        ),
      );
    }
  }

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
        children: <Widget>[
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          qnaMenu(),
                          expMenu(),
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
            child: buildPostContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (selectedMenuIndex == 0) {
              Get.to(() => QnaWriteScreen());
            } else {
              Get.to(() => ExpWriteScreen());
            }
          },
          elevation: 4,
          label: const Text('글쓰기'),
          icon: const Icon(Icons.mode_edit_outlined),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.contentColorPink),
    );
  }
}

class QnaPostsListView extends StatelessWidget {
  QnaPostsListView({super.key});
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    QnaPostController p = Get.put(QnaPostController());

    return Obx(
      () => RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await p.getQnaPostsList();
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: p.posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                    Get.to(() => DetailScreen(id: p.posts[index].postId));
                  },
                  child: qnaCustomListItem(p, index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExpPostsListView extends StatelessWidget {
  ExpPostsListView({super.key});
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    ExpPostController p = Get.put(ExpPostController());

    // getExpPostsList()에서 await 이후, 변수 posts에 저장이 되면, 그 변화를 감지해서 화면을 다시 그리기 위해 Obx로 ListView를 감싸줌
    return Obx(
      () => RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await p.getExpPostsList();
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: p.posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                    Get.to(() => DetailScreen(id: p.posts[index].postId));
                  },
                  child: expCustomListItem(p, index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget qnaCustomListItem(QnaPostController p, int index) {
  var postDate = p.posts[index].createdDate;
  int daysDifference = calculatePassedDays(postDate!);

  print(p.posts[index].postId);

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

Widget expCustomListItem(ExpPostController p, int index) {
  var postDate = p.posts[index].createdDate;
  int daysDifference = calculatePassedDays(postDate!);
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
