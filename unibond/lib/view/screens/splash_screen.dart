import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/util/auth_storage.dart';
import 'package:unibond/view/screens/user/join_screen.dart';
import 'package:unibond/view/screens/user/login_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    String? memberId = await AuthStorage.getAuthToken();

    // SecureStorage 초기화를 위해 회원가입 화면으로 이동시키기
    // memberId = null;
    // 이 방법은 Storage에 저장은 되어있는데 덮어쓰기위한거니까 기기에서 아예 삭제하려면 delAuthToken()을 해야함.
    // AuthStorage.delAuthToken();

    if (memberId != null) {
      // 인증된 사용자면
      try {
        final profile = await getMyProfile(memberId);
        if (!mounted) return;
        if (profile.isSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const RootTab()));
        } else {
          // 프로필 조회 실패 눈송해피
          _navigateToRegister();
        }
      } catch (e) {
        // 오류 처리
        _navigateToRegister();
      }
    } else {
      // 인증되지 않은 사용자
      // _navigateToRegister();
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const JoinScreen(),
      ),
    );
  }

  // 나의 프로필 조회 함수
  Future<UserProfile> getMyProfile(String memberId) async {
    final dio = Dio();
    final response = await dio.get(
      'http://3.35.110.214/api/v1/members/$memberId',
      options: Options(headers: {'Authorization': memberId}),
    );
    return UserProfile.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.contentColorWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
