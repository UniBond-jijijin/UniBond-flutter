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
  String aboutAMinute(int minutes) => '$minutes분 전';
  @override
  String minutes(int minutes) => '$minutes분 전';
  @override
  String aboutAnHour(int minutes) => '$minutes분 전';
  @override
  String hours(int hours) => '$hours시간 전';
  @override
  String aDay(int hours) => '$hours시간 전';
  @override
  String days(int days) => '$days일 전';
  @override
  String aboutAMonth(int days) => '$days일 전';
  @override
  String months(int months) => '$months개월 전';
  @override
  String aboutAYear(int year) => '$year년 전';
  @override
  String years(int years) => '$years년 전';
  @override
  String wordSeparator() => ' ';
}
