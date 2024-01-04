import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/controller/dto/receive_letter_get_dto.dart';
import 'package:unibond/controller/dto/send_letter_get_dto.dart';
import 'package:unibond/domain/letter/letter_provider.dart';
import 'package:unibond/domain/letter/pre_receive_letter.dart';
import 'package:unibond/domain/letter/pre_send_letter.dart';

const host = "http://3.35.110.214";

class LetterRepository {
  final LetterProvider _letterProvider = LetterProvider();

  Future<bool> sendLetter(
      String receiverId, String title, String content) async {
    try {
      final LetterReqDto letterReqDto = LetterReqDto(
        receiverId: receiverId,
        title: title,
        content: content,
      );

      print(letterReqDto.toJson());
      Response response =
          await _letterProvider.sendLetter(letterReqDto.toJson());

      bool isSuccess = response.body["isSuccess"];
      return isSuccess;
    } catch (error) {
      print("Failed: $error");
      rethrow;
    }
  }

  Future<List<PreSendLetter>> getSentLetters() async {
    try {
      Response response = await _letterProvider.getSentLetters({});
      dynamic body = response.body;
      SendLetterGetDto sendLetterGetDto = SendLetterGetDto.fromJson(body);

      if (sendLetterGetDto.code == 1000) {
        Map<String, dynamic> tempMap = sendLetterGetDto.result;
        List<dynamic> templist = tempMap["preSendLetter"];
        List<PreSendLetter> preSendLetter =
            templist.map((letter) => PreSendLetter.fromJson(letter)).toList();
        return preSendLetter;
        // PrevPost
      } else {
        throw Exception("Failed to get sent letters");
      }
    } catch (err) {
      print("Failed to get sentletter list: $err");
      rethrow;
    }
  }

  Future<List<PreReceiveLetter>> getReceivedLetters() async {
    try {
      Response response = await _letterProvider.getReceivedLetters({});
      dynamic body = response.body;
      ReceiveLetterGetDto receiveLetterGetDto =
          ReceiveLetterGetDto.fromJson(body);

      if (receiveLetterGetDto.code == 1000) {
        Map<String, dynamic> tempMap = receiveLetterGetDto.result;
        List<dynamic> templist = tempMap["preReceiveLetter"];
        List<PreReceiveLetter> preReceiveLetter = templist
            .map((letter) => PreReceiveLetter.fromJson(letter))
            .toList();
        return preReceiveLetter;
      } else {
        throw Exception('Failed to get received letters');
      }
    } catch (error) {
      print("Failed: $error");
      rethrow;
    }
  }
}
