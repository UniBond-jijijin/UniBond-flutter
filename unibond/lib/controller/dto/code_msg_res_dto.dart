class CodeMsgResDto {
  final bool? isSuccess;
  final int? code;
  final String? msg;
  final dynamic result;

  CodeMsgResDto(this.isSuccess, this.code, this.msg, this.result);

  CodeMsgResDto.fromJson(Map<String, dynamic> json)
      : isSuccess = json["isSuccess"],
        code = json["code"],
        msg = json["message"],
        result = json["result"];
}

class CodeMsgDto {
  final bool? isSuccess;
  final int? code;
  final String? msg;

  CodeMsgDto(this.isSuccess, this.code, this.msg);

  CodeMsgDto.fromJson(Map<String, dynamic> json)
      : isSuccess = json["isSuccess"],
        code = json["code"],
        msg = json["message"];
}
