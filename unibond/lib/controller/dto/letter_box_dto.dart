class LetterBoxDto {
  final bool? isSuccess;
  final int? code;
  final String? msg;
  final dynamic result;

  LetterBoxDto(this.isSuccess, this.code, this.msg, this.result);

  LetterBoxDto.fromJson(Map<String, dynamic> json)
      : isSuccess = json["isSuccess"],
        code = json["code"],
        msg = json["message"],
        result = json["result"];
}
