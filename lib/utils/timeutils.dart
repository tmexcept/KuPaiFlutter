
import 'package:flutter/material.dart';

String transferSeconds2Period(int totalSeconds) {
  int days, hours, minutes, seconds;

  days = (totalSeconds / 86400).floor();
  hours = (totalSeconds % 86400 / 3600).floor();
  minutes = (totalSeconds % 86400 % 3600 / 60).floor();
  seconds = totalSeconds % 86400 % 3600 % 60;
  String result = "";

  if (days > 0)
    result = "$days天";
  if (hours > 0)
    result += "$hours时";
  if (minutes > 0)
    result += "$minutes分";
  if (seconds > 0)
    result += "$seconds秒";
  return result;
}

String getStartTimeString2(int startTime){
  DateTime nowTime = new DateTime.now();//当前时间
  var time = new DateTime.fromMillisecondsSinceEpoch(startTime*1000);
  StringBuffer str = new StringBuffer();
  if (time.year == nowTime.year && time.month == nowTime.month) {
    if (time.day == nowTime.day) {
      str.write("今天");
    } else if (time.day == nowTime.day+1) {
      str.write("明天");
    }
  }
  str.write("${time.month}月${time.day}日");
  return str.toString();
}

String getStartTimeStringEnd(int endTime){
  DateTime nowTime = new DateTime.now();//当前时间
  var time = new DateTime.fromMillisecondsSinceEpoch(endTime*1000);
  debugPrint("endTime = $time");

  if (time.year == nowTime.year && time.month == nowTime.month) {
    if (time.day == nowTime.day) {
      return "今天 ${time.hour}:${getMinutes(time.minute)}";
    } else if (time.day == nowTime.day+1) {
      return "明天 ${time.hour}:${getMinutes(time.minute)}";
    }
  }
  return "${time.month}月${time.day}日 ${time.hour}:${getMinutes(time.minute)}";
}

String getMonthDayMinuteSecond(int times){
  var time = new DateTime.fromMillisecondsSinceEpoch(times);
  return "${time.month}月${time.day}日 ${time.hour}:${getMinutes(time.minute)}";
}

String getMinutes(int minute){
  return minute == 0 ? "00": minute.toString();
}