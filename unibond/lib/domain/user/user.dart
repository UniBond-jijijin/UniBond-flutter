import 'package:intl/intl.dart';

class User {
  final int? id;
  final int? diseaseId;
  final DateTime? diseaseTiming;
  final String? gender;
  final String? nickname;
  final String? email;
  final String? bio;
  final List<String>? interestList;

  User({
    this.id,
    this.diseaseId,
    this.diseaseTiming,
    this.gender,
    this.nickname,
    this.email,
    this.bio,
    this.interestList,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        diseaseId = json["diseaseId"],
        diseaseTiming = DateFormat("yyyy-mm-dd").parse(json["diseaseTiming"]),
        gender = json["gender"],
        nickname = json["nickname"],
        email = json["email"],
        bio = json["bio"],
        interestList = json["interestList"];

  // 임시
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id.trim(),
  //     'email': email.trim(),
  //     'nickname': nickname.trim(),
  //   };
  // }
}
