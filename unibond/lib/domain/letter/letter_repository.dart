import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/domain/letter/letter_provider.dart';

const host = "http://3.35.110.214";

class LetterRepository {
  final LetterProvider _letterProvider = LetterProvider();

  Future<bool> sendLetter(int receiverId, String content, String title) async {
    try {
      final LetterReqDto letterReqDto = LetterReqDto(
        receiverId: receiverId,
        content: content,
        title: title,
      );
      Response response =
          await _letterProvider.sendLetter(letterReqDto.toJson());

      print(response.body);
      print(response.body["isSuccess"]);

      bool isSuccess = response.body["isSuccess"];
      print("전송 성공 여부: $isSuccess");
      return isSuccess;
    } catch (error) {
      print("Failed");
      print(error);
      throw error;
    }
  }
}
