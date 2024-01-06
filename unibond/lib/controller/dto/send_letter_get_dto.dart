class SendLetterGetDto {
  final bool? isSuccess;
  final int? code;
  final String? msg;
  final dynamic result;

  SendLetterGetDto(this.isSuccess, this.code, this.msg, this.result);

  SendLetterGetDto.fromJson(Map<String, dynamic> json)
      : isSuccess = json["isSuccess"],
        code = json["code"],
        msg = json["message"],
        result = json["result"];
}
