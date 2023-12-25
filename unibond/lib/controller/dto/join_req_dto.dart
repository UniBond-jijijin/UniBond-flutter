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

  // TODO: timing, list 자료형 처리 필요
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "password": password,
        "diseaseId": diseaseId,
        "diseaseTiming": diseaseTiming,
        "gender": gender,
        "nickname": nickname,
        "bio": bio,
        "interestList": interestList,
        // "email": email,
        // "username": username,
        // "password": password,
      };
}
