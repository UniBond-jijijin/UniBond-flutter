import 'package:timeago_flutter/timeago_flutter.dart';

class PostTime implements LookupMessages {
  PostTime(DateTime converToDateTime);

  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '방금 전';
  @override
  String aboutAMinute(int minutes) => '${minutes}분 전';
  @override
  String minutes(int minutes) => '${minutes}분 전';
  @override
  String aboutAnHour(int minutes) => '${minutes}분 전';
  @override
  String hours(int hours) => '${hours}시간 전';
  @override
  String aDay(int hours) => '${hours}시간 전';
  @override
  String days(int days) => '${days}일 전';
  @override
  String aboutAMonth(int days) => '${days}일 전';
  @override
  String months(int months) => '${months}개월 전';
  @override
  String aboutAYear(int year) => '${year}년 전';
  @override
  String years(int years) => '${years}년 전';
  @override
  String wordSeparator() => ' ';
}
