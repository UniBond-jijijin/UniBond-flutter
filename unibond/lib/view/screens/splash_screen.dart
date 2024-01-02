// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:unibond/resources/app_colors.dart';
// import 'package:unibond/util/auth_storage.dart';
// import 'package:unibond/view/screens/home_screen.dart';
// import 'package:unibond/view/screens/user/join_screen.dart';
// import 'package:unibond/view/screens/user/root_tab.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthAndNavigate();
//   }

//   void _checkAuthAndNavigate() async {
//     String? memberId = await AuthStorage.getAuthToken();

//     if (memberId != null) {
//       // 인증된 사용자면
//       try {
//         final profile = await getMyProfile(memberId);
//         if (profile.isSuccess) {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => const RootTab()));
//         } else {
//           // 프로필 조회 실패
//           _navigateToRegister();
//         }
//       } catch (e) {
//         // 오류 처리
//         _navigateToRegister();
//       }
//     } else {
//       // 인증되지 않은 사용자
//       _navigateToRegister();
//     }
//   }

//   void _navigateToRegister() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => JoinScreen(),
//       ),
//     );
//   }

//   // 나의 프로필 조회 함수
//   Future<UserProfile> getMyProfile(String memberId) async {
//     final dio = Dio();
//     final response = await dio.get(
//       'http://3.35.110.214/api/v1/members/$memberId',
//       options: Options(headers: {'Authorization': memberId}),
//     );
//     return UserProfile.fromJson(response.data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           color: AppColors.contentColorWhite,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     width: 200,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Future<UserProfie> getMyProfile(String memberId) {}
// }
