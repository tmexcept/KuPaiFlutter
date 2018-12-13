
String transferSeconds2Period(int totalSeconds) {
  int days, hours, minutes, seconds;

  days = (totalSeconds / 86400).round();
  hours = (totalSeconds % 86400 / 3600).round();
  minutes = (totalSeconds % 86400 % 3600 / 60).round();
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
  var time = new DateTime.fromMillisecondsSinceEpoch(startTime);
  if (time.year == nowTime.year && time.month == nowTime.month) {
    if (time.day == nowTime.day) {
      return "专场 今天 开始";
    } else if (time.day == nowTime.day+1) {
      return "专场 明天 开始";
    }
  }
  return ("专场 ${time.month}月${time.day}日 开始");
}

String getStartTimeStringEnd(int endTime){
  DateTime nowTime = new DateTime.now();//当前时间
  var time = new DateTime.fromMillisecondsSinceEpoch(endTime);

  if (time.year == nowTime.year && time.month == nowTime.month) {
    if (time.day == nowTime.day) {
      return "今天 ${time.minute}:${time.second}";
    } else if (time.day == nowTime.day+1) {
      return "明天 ${time.minute}:${time.second}";
    }
  }
  return "${time.month}月${time.day}日 ${time.minute}:${time.second}";
}

String getMonthDayMinuteSecond(int times){
  var time = new DateTime.fromMillisecondsSinceEpoch(times);
  return "${time.month}月${time.day}日 ${time.minute}:${time.second}";
}