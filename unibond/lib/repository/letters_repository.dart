import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:unibond/model/letter/all_letter_boxs.dart';
import 'package:unibond/model/letter/received_letter_detail.dart';
import 'package:unibond/model/letter/sent_letter_detail.dart';
import 'package:unibond/util/auth_storage.dart';

// 기존 방식: GetX obs 이용해서 편지 리스트 추가되면 재렌더링 하는 방식
// 지금 방식: 편지함 들어갈때마다 Get요청 보내기
// 변경 이유: 시간이 부족해서 최대한 간단하게 구현하기 위함

// 나의 편지함 조회
Future<LetterBoxRequest> getMyLetterBox() async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();
  dio.interceptors.add(LogInterceptor(
    responseBody: true, // 응답 본문을 찍을지 여부
  ));

  final response = await dio.get(
    'http://3.35.110.214/api/v1/letter-rooms',
    options: Options(headers: {'Authorization': authToken}),
  );

  return LetterBoxRequest.fromJson(response.data);
}

// class LetterController extends GetxController {
//   final LetterRepository _letterRepository = LetterRepository();
//   final getsendletter = <PreSendLetter>[].obs;
//   final getreceiveletter = <ReceivedLetter>[].obs;
//   final letterRoom = <LetterRoom>[].obs;

//   Future<bool> sendLetter(
//     String receiverId,
//     String title,
//     String content,
//   ) async {
//     try {
//       bool isSuccess =
//           await _letterRepository.sendLetter(receiverId, title, content);
//       return isSuccess;
//     } catch (error) {
//       print('sendLetter error: $error');
//       rethrow;
//     }
//   }

//   Future<void> getSentLetters() async {
//     try {
//       List<PreSendLetter> getsendletter =
//           await _letterRepository.getSentLetters();
//       this.getsendletter.value = getsendletter;
//     } catch (error) {
//       print('getSentLetters error: $error');
//       rethrow;
//     }
//   }

//   // 내가 받은 편지 목록 가져오기
//   Future<void> getReceivedLetters() async {
//     try {
//       List<ReceivedLetter> getreceiveletter =
//           await _letterRepository.getReceivedLetters();
//       this.getreceiveletter.value = getreceiveletter;
//     } catch (error) {
//       print('getReceivedLetters error: $error');
//       rethrow;
//     }
//   }

//   Future<void> getAllLetterRooms() async {
//     try {
//       List<LetterRoom> letterRoom = await _letterRepository.getAllLetterRooms();
//       this.letterRoom.value = letterRoom;
//     } catch (error) {
//       print('getAllLetterRooms error: $error');
//       // Handle error if needed
//     }
//   }
// }
