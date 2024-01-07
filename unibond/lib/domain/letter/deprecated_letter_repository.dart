// import 'package:get/get.dart';
// import 'package:unibond/controller/dto/letter_req_dto.dart';
// import 'package:unibond/domain/letter/letter_provider.dart';
// import 'package:unibond/controller/dto/receive_letter_get_dto.dart';
// import 'package:unibond/controller/dto/send_letter_get_dto.dart';
// import 'package:unibond/model/letter/all_letter_rooms.dart';
// import 'package:unibond/model/letter/received_letter_detail.dart';
// import 'package:unibond/model/letter/sent_letter_detail.dart';

// const host = "http://3.35.110.214";

// class LetterRepository {
//   final LetterProvider _letterProvider = LetterProvider();

//   Future<bool> sendLetter(
//       String receiverId, String title, String content) async {
//     try {
//       final LetterReqDto letterReqDto = LetterReqDto(
//         receiverId: receiverId,
//         title: title,
//         content: content,
//       );

//       print(letterReqDto.toJson());
//       Response response =
//           await _letterProvider.sendLetter(letterReqDto.toJson());

//       bool isSuccess = response.body["isSuccess"];
//       return isSuccess;
//     } catch (error) {
//       print("Failed: $error");
//       rethrow;
//     }
//   }

//   Future<List<PreSendLetter>> getSentLetters() async {
//     try {
//       Response response = await _letterProvider.getSentLetters({});
//       dynamic body = response.body;
//       SendLetterGetDto sendLetterGetDto = SendLetterGetDto.fromJson(body);

//       if (sendLetterGetDto.code == 1000) {
//         Map<String, dynamic> tempMap = sendLetterGetDto.result;
//         List<dynamic> templist = tempMap["preSendLetter"];
//         List<PreSendLetter> preSendLetter =
//             templist.map((letter) => PreSendLetter.fromJson(letter)).toList();
//         return preSendLetter;
//         // PrevPost
//       } else {
//         throw Exception("Failed to get sent letters");
//       }
//     } catch (err) {
//       print("Failed to get sentletter list: $err");
//       rethrow;
//     }
//   }

//   Future<List<ReceivedLetter>> getReceivedLetters() async {
//     try {
//       Response response = await _letterProvider.getReceivedLetters({});
//       dynamic body = response.body;
//       ReceiveLetterGetDto receiveLetterGetDto =
//           ReceiveLetterGetDto.fromJson(body);

//       if (receiveLetterGetDto.code == 1000) {
//         Map<String, dynamic> tempMap = receiveLetterGetDto.result;
//         List<dynamic> templist = tempMap["preReceiveLetter"];
//         List<ReceivedLetter> preReceiveLetter =
//             templist.map((letter) => ReceivedLetter.fromJson(letter)).toList();
//         return preReceiveLetter;
//       } else {
//         throw Exception('Failed to get received letters');
//       }
//     } catch (error) {
//       print("Failed: $error");
//       rethrow;
//     }
//   }

//   Future<List<LetterRoom>> getAllLetterRooms() async {
//     try {
//       Response response = await _letterProvider.getAllLetterRooms();
//       dynamic body = response.body;
//       LetterRoomDto letterRoomDto = LetterRoomDto.fromJson(body);

//       if (letterRoomDto.code == 1000) {
//         Map<String, dynamic> tempMap =
//             letterRoomDto.result as Map<String, dynamic>;
//         List<dynamic> templist = tempMap["letterRoomList"];
//         List<LetterRoom> letterRoom =
//             templist.map((letter) => LetterRoom.fromJson(letter)).toList();
//         return letterRoom;
//       } else {
//         throw Exception('Failed to get received letters');
//       }
//     } catch (error) {
//       print("Failed: $error");
//       rethrow;
//     }
//   }
// }
