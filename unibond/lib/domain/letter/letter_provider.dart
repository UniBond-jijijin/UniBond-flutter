import 'package:get/get.dart';

const host = "http://3.35.110.214";

class LetterProvider extends GetConnect {
  Future<Response> sendLetter(Map data) => post(
      '$host/api/v1/letters',
      headers: {"Authorization": "26"}, // 실제 userIdNum을 넣어야함
      data);

  Future<Response> getSentLetters(Map data) => get(
        '$host/api/v1/letters/2',
        headers: {"Authorization": "3"}, // 실제 userIdNum을 넣어야함
      );
  Future<Response> getReceivedLetters(Map data) => get(
        '$host/api/v1/letters/2',
        headers: {"Authorization": "3"}, // 실제 userIdNum을 넣어야함
      );

  Future<Response> getAllLetterRooms() => get(
        '$host/api/v1/letter-rooms?page=0',
        headers: {"Authorization": "29"},
      );
}
