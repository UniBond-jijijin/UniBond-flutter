import 'package:get/get.dart';
import 'package:unibond/controller/dto/letter_req_dto.dart';
import 'package:unibond/domain/letter/letter_provider.dart';
import 'package:unibond/util/userIdNum.dart';

const host = "http://3.35.110.214";

class LetterProvider extends GetConnect {
  Future<Response> sendLetter(Map data) => post(
      '$host/api/v1/letters',
      headers: {"Authorization": userIdNum ?? ""},
      data);
}
