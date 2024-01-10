import 'package:dio/dio.dart';
import 'package:unibond/controller/dto/code_msg_res_dto.dart';
import 'package:unibond/model/letter/all_letter_boxs.dart';
import 'package:unibond/model/letter/all_letters.dart';
import 'package:unibond/model/letter/received_letter_detail.dart';
import 'package:unibond/model/letter/send_letter.dart';
import 'package:unibond/model/letter/sent_letter_detail.dart';
import 'package:unibond/util/auth_storage.dart';

// 기존 방식: GetX obs 이용해서 편지 리스트 추가되면 재렌더링 하는 방식
// 지금 방식: 편지함 들어갈때마다 Get요청 보내기
// 변경 이유: 시간이 부족해서 최대한 간단하게 구현하기 위함

// 나의 편지함 조회
Future<LetterBoxRequest> getMyLetterBox() async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/letter-rooms',
    options: Options(headers: {'Authorization': authToken}),
  );

  return LetterBoxRequest.fromJson(response.data);
}

// 편지함 내부 편지들 조회
// api 명세에 따라 변수명 room으로 설정
Future<AllLettersRequest> getAllLettersRequest(String letterRoomId) async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/letter-rooms/$letterRoomId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return AllLettersRequest.fromJson(response.data);
}

// 받은 편지 조회
Future<ReceivedLetterDetail> getReceivedLetterDetail(String letterId) async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.get(
    'http://3.35.110.214/api/v1/letters/$letterId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return ReceivedLetterDetail.fromJson(response.data);
}

// 보낸 편지 조회
Future<SentLetterDetail> getSentLetterDetail(String letterId) async {
  final dio = Dio();

  String? authToken = await AuthStorage.getAuthToken();
  dio.interceptors.add(LogInterceptor(
    responseBody: true,
  ));

  final response = await dio.get(
    'http://3.35.110.214/api/v1/letters/$letterId',
    options: Options(headers: {'Authorization': authToken}),
  );

  return SentLetterDetail.fromJson(response.data);
}

// 편지 전송
Future<CodeMsgResDto> postLetter(LetterPostRequest letterPostRequest) async {
  final dio = Dio();
  String? authToken = await AuthStorage.getAuthToken();

  final response = await dio.post(
    'http://3.35.110.214/api/v1/letters',
    data: letterPostRequest.toJson(),
    options: Options(headers: {'Authorization': authToken}),
  );
  return CodeMsgResDto.fromJson(response.data);
}

// 토큰값 반환 함수
// 보안에 문제가 있는지어쩐지는 모름.
Future<String> getAuthToken() async {
  String? authToken = await AuthStorage.getAuthToken();
  return authToken!;
}

// 토큰값 vs Id 비교 함수
Future<bool> compareAuthToken(String id) async {
  String? authToken = await AuthStorage.getAuthToken();
  return authToken! == id;
}
