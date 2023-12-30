import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/domain/letter/letter.dart';
import 'package:unibond/domain/letter/letter_provider.dart';
import 'package:unibond/domain/letter/letter_repository.dart';

class LetterController extends GetxController {
  final LetterRepository _letterRepository = LetterRepository();

  Future<bool> sendLetter(int receiverId, String content, String title) async {
    try {
      bool isSuccess =
          await _letterRepository.sendLetter(receiverId, content, title);
      print('sendLetter result: $isSuccess');
      return isSuccess;
    } catch (error) {
      print('sendLetter error: $error');
      rethrow;
    }
  }
}
