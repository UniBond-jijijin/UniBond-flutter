import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/domain/letter/letter_provider.dart';
import 'package:unibond/domain/letter/letter_repository.dart';
import 'package:unibond/domain/letter/pre_receive_letter.dart';
import 'package:unibond/domain/letter/pre_send_letter.dart';

class LetterController extends GetxController {
  final LetterRepository _letterRepository = LetterRepository();
  final getsendletter = <PreSendLetter>[].obs;
  final getreceiveletter = <PreReceiveLetter>[].obs;

  Future<bool> sendLetter(
    String receiverId,
    String title,
    String content,
  ) async {
    try {
      bool isSuccess =
          await _letterRepository.sendLetter(receiverId, title, content);
      return isSuccess;
    } catch (error) {
      print('sendLetter error: $error');
      rethrow;
    }
  }

  // 내가 보낸 편지 목록 가져오기
  Future<void> getSentLetters() async {
    try {
      List<PreSendLetter> getsendletter =
          await _letterRepository.getSentLetters();
      this.getsendletter.value = getsendletter;
    } catch (error) {
      print('getSentLetters error: $error');
      rethrow;
    }
  }

  // 내가 받은 편지 목록 가져오기
  Future<void> getReceivedLetters() async {
    try {
      List<PreReceiveLetter> getreceiveletter =
          await _letterRepository.getReceivedLetters();
      this.getreceiveletter.value = getreceiveletter;
    } catch (error) {
      print('getReceivedLetters error: $error');
      rethrow;
    }
  }
}
