class LetterRoomDto {
  final bool isSuccess;
  final int code;
  final String message;
  final LetterRoomResultDto result;

  LetterRoomDto({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory LetterRoomDto.fromJson(Map<String, dynamic> json) {
    return LetterRoomDto(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: LetterRoomResultDto.fromJson(json['result']),
    );
  }
}

class LetterRoomResultDto {
  final List<LetterRoom> letterRoomList;
  final PageInfoDto pageInfo;

  LetterRoomResultDto({
    required this.letterRoomList,
    required this.pageInfo,
  });

  factory LetterRoomResultDto.fromJson(Map<String, dynamic> json) {
    return LetterRoomResultDto(
      letterRoomList: List<LetterRoom>.from(
        json['letterRoomList'].map((x) => LetterRoom.fromJson(x)),
      ),
      pageInfo: PageInfoDto.fromJson(json['pageInfo']),
    );
  }
}

class LetterRoom {
  final String senderProfileImg;
  final String senderNick;
  final int senderId;
  final String recentLetterSentDate;
  final int letterRoomId;

  LetterRoom({
    required this.senderProfileImg,
    required this.senderNick,
    required this.senderId,
    required this.recentLetterSentDate,
    required this.letterRoomId,
  });

  factory LetterRoom.fromJson(Map<String, dynamic> json) {
    return LetterRoom(
      senderProfileImg: json['senderProfileImg'],
      senderNick: json['senderNick'],
      senderId: json['senderId'],
      recentLetterSentDate: json['recentLetterSentDate'],
      letterRoomId: json['letterRoomId'],
    );
  }
}

class PageInfoDto {
  final int numberOfElements;
  final bool lastPage;
  final int totalPages;
  final int totalElements;
  final int size;

  PageInfoDto({
    required this.numberOfElements,
    required this.lastPage,
    required this.totalPages,
    required this.totalElements,
    required this.size,
  });

  factory PageInfoDto.fromJson(Map<String, dynamic> json) {
    return PageInfoDto(
      numberOfElements: json['numberOfElements'],
      lastPage: json['lastPage'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      size: json['size'],
    );
  }
}
