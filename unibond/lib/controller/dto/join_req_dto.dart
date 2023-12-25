class JoinReqDto {
  final String? diseaseId;
  // TODO: 자료형 나중에 반영
  final String? diseaseTiming;
  final String? gender;
  final String? nickname;
  final String? bio;
  // TODO: 자료형 나중에 반영
  final String? interestList;
  // 일단 api 문서에 없어서 주석처리
  // final String? email;
  final String? userId;
  final String? password;

  JoinReqDto(
    // this.email,
    this.userId,
    this.password,
    this.diseaseId,
    this.diseaseTiming,
    this.gender,
    this.nickname,
    this.bio,
    this.interestList,
  );

  // TODO: timing, list 자료형 처리 필요, 임시 값 수정 필요
  Map<String, dynamic> toJson() => {
        // "userId": userId,
        // "password": password,
        "diseaseId": 1, // 임시 아이디
        "diseaseTiming": "2023-11-10", // 예시 문자열
        "gender": "FEMALE",
        "nickname": nickname,
        "bio": bio,
        "interestList": ["환우회", "친목", "운동"], // 예시 리스트
      };
}
