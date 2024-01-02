import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/domain/letter/letter_provider.dart';

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
}
