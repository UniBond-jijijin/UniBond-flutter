import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/view/screens/community/post_detail_screen.dart';
import 'package:unibond/view/screens/splash_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:unibond/view/screens/user/root_tab.dart';

void main() {
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const RootTab()),
      ],
    );
  }
}
