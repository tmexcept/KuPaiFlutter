
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:flutterapp/utils/timeutils.dart';

class AuctionListItemWidget extends StatefulWidget{

  final BidList data;
  AuctionListItemWidget({Key key, this.data});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AuctionListItemState(data);
  }
}

class AuctionListItemState extends State<AuctionListItemWidget>{
  final BidList data;
  AuctionListItemState(this.data);
  int color;
  String countDownDes;
  String countDown;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(data.bidStatus == 2){
      _startTimer();

      getCountDownStatus2();
//      countDown = getCountDownStatus2(data.leftStartTime, data.startTime);
    } else if(data.bidStatus == 3){
      _startTimer();

      getCountDownStatus3();

    } else if (data.bidStatus == 8 || data.bidStatus == 9 || data.bidStatus == 10){
      countDownDes = "拍卖暂停";
      countDown = null;
    } else {
      countDownDes = "已结束 ${getMonthDayMinuteSecond(data.endTime)}已结拍";
      countDown = null;
    }

    if(data.bidStatus == 2){
      color = 0xffb28147;
    } else if(data.bidStatus == 3){
      color = 0xffc4301d;
    } else
      color = 0xff7e7e7e;
  }

  getCountDownStatus2(){
    if (data.leftStartTime < 7200) {
      if (data.startTime > 0) {
        if (data.leftStartTime > 0) {
          countDownDes = "预展中 ";
          countDown = "距开始：${transferSeconds2Period(data.leftStartTime)}";
        } else {
          countDownDes =  "热拍中";
          countDown = null;
        }
      } else {
        countDownDes = "预展中";
        countDown = null;
      }
    } else {
      if (data.startTime == 0) {
        countDownDes =  "预展中";
        countDown = null;
      } else {
        countDownDes =  "预展中 ";
        countDown = "专场 ${getStartTimeString2(data.startTime)} 开始";
      }
    }
  }
  getCountDownStatus3(){
    if (data.endTime > 0) {
      if(data.leftEndTime>0 && data.leftEndTime<7200) {
        countDownDes =  "热拍中 ";
        countDown = "距结束：${transferSeconds2Period(data.leftEndTime)}";
      }else if(data.leftEndTime>7200){
        countDownDes =  "热拍中 ";
        countDown = "${getStartTimeStringEnd(data.endTime)} 结束";
      } else {
        countDownDes =  "已结束 ";
        countDown = "${getMonthDayMinuteSecond(data.endTime*1000)}已结拍";
      }
    } else {
      countDownDes =  "热拍中";
      countDown = null;
    }
  }

  List<TextSpan> getCountDown(){
    List<TextSpan> spans = [];
    if(countDownDes != null && countDownDes.isNotEmpty)
      spans.add(new TextSpan(text: "$countDownDes",style: new TextStyle(fontSize: 11.0, color: Colors.white),));
    if(countDown != null && countDown.isNotEmpty)
      spans.add(new TextSpan(text: "$countDown",style: new TextStyle(fontSize: 8.0, color: Colors.white),));
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(color: Color(color), borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
      padding: const EdgeInsets.only(left:10.0,top:5.0,right:10.0,bottom:5.0),
      child: RichText(text: new TextSpan(children: getCountDown()),
      ),
    );


//    return Material(
//      color: Color(color),
//      child: new Container(
//        decoration: BoxDecoration(color: Color(color), borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
//        padding: const EdgeInsets.only(left:10.0,top:5.0,right:10.0,bottom:5.0),
//        child: new Text("$countDown",style: new TextStyle(fontSize: 11.0, color: Colors.white),),
//      ),
//      shape: RoundedRectangleBorder(side: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
//    );
  }

  @override
  void dispose(){
    _cancelTimer();
    super.dispose();
  }

  Timer _timer;
  _startTimer() {
    if(_timer != null && _timer.isActive) return;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
//         debugPrint("data.leftEndTime = ${data.leftEndTime}");
      setState(() {
        if(data.bidStatus == 2){
          getCountDownStatus2();
        } else if(data.bidStatus == 3){
          getCountDownStatus3();
        }
      });
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

}