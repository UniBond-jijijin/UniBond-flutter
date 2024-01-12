import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unibond/model/user_profile.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/util/auth_storage.dart';
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

    if (memberId != null) {
      // 인증된 사용자면
      try {
        final profile = await getMyProfile(memberId);
        if (!mounted) return;
        if (profile.isSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const RootTab()));
        } else {
          // 프로필 조회 실패
          _navigateToLogin();
        }
      } catch (e) {
        // 오류 처리
        _navigateToLogin();
      }
    } else {
      // 인증되지 않은 사용자
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
      body: Semantics(
        // 대체 텍스트를 설정합니다.
        label: '앱 스플래시 화면',
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.contentColorWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                label: '유니본드 로고',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '이 앱은 현대오토에버와 서울사회복지',
                            style: letterContentTextStyle,
                            // textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            // maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '공동모금회의 지원으로 제작되었습니다.',
                            style: letterContentTextStyle,
                            // textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            // maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
