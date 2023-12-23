import 'package:validators/validators.dart';

bool isValid(formKey) => formKey.currentState!.validate();

Function validateEmail = (String? value) {
  if (value == null || value.isEmpty) {
    return "값을 입력해주세요.";
  } else if (!isEmail(value)) {
    return "이메일의 형식에 맞게 입력해주세요.";
  } else {
    return null; // 유효한 경우에는 null 반환
  }
};

Function validateId = (String? value) {
  if (value == null || value.isEmpty) {
    return "값을 입력해주세요.";
  } else if (!isAlphanumeric(value)) {
    return "아이디에는 한글이나 특수문자가 들어갈 수 없습니다.";
  } else if (value.length > 12) {
    return "아이디는 12자 이하로 입력해주세요.";
  } else if (value.length < 4) {
    return "아이디의 최소 길이는 4자입니다.";
  } else {
    return null;
  }
};

Function validatePassword = (String? value) {
  if (value == null || value.isEmpty) {
    return "값을 입력해주세요.";
  } else if (value.length > 12) {
    return "비밀번호는 12자 이하로 입력해주세요.";
  } else if (value.length < 4) {
    return "비밀번호의 최소 길이는 4자입니다.";
  } else {
    return null;
  }
};

Function validateTitle = (String? value) {
  if (value == null || value.isEmpty) {
    return "값을 입력해주세요.";
  } else if (value.length > 30) {
    return "제목은 30자 이하로 입력해주세요.";
  } else {
    return null;
  }
};

Function validateContent = (String? value) {
  if (value == null || value.isEmpty) {
    return "값을 입력해주세요.";
  } else if (value.length > 500) {
    return "내용은 500자 이하로 입력해주세요.";
  } else {
    return null;
  }
};
