class WithdrawDto {
  final bool isSuccess;
  final int code;
  final String message;

  WithdrawDto({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  factory WithdrawDto.fromJson(Map<String, dynamic> json) {
    return WithdrawDto(
      isSuccess: json['isSuccess'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
