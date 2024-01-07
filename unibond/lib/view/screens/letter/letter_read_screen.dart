// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unibond/model/letter/received_letter_detail.dart';
// import 'package:unibond/view/screens/letter/letter_write_screen.dart';
// import 'package:unibond/view/widgets/custom_elevated_button.dart';

// class LetterReadScreen extends StatefulWidget {
//   // final ReceivedLetterDetail receivedLetterDetail;

//   const LetterReadScreen({Key? key}) : super(key: key);

//   @override
//   _LetterReadScreenState createState() => _LetterReadScreenState();
// }

// class _LetterReadScreenState extends State<LetterReadScreen> {
//   // Placeholder values for testing
//   String arriveDate = '2022-01-01';
//   String senderNick = 'John Doe';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Column(
//           children: [
//             Text('받은 편지'),
//           ],
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               // widget.letter.isliked! ? Icons.bookmark : Icons.bookmark_border,
//               Icons.bookmark,
//             ),
//             onPressed: () {
//               setState(() {
//                 // widget.letter.isliked = !widget.letter.isliked!;
//                 // 북마크 상태 저장 필요
//               });
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/letterread.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     '도착시간: $arriveDate',
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   Text(
//                     senderNick,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   const Text(
//                     "widget.letter.title", // 임시
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "widget.letter.content", // 임시
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   CustomElevatedButton(
//                     text: "답장 쓰기",
//                     screenRoute: () {
//                       Get.to(() => LetterWriteScreen());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
