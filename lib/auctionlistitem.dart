
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
  String countDown;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(data.bidStatus == 2){
      _startTimer();
      countDown = getCountDownStatus2(data.leftStartTime, data.startTime);
    } else if(data.bidStatus == 3){
      _startTimer();
      countDown = getCountDownStatus3(data.leftEndTime, data.endTime);
    } else if (data.bidStatus == 8 || data.bidStatus == 9 || data.bidStatus == 10){
      countDown = "拍卖暂停";
    } else {
      countDown = "已结束 ${getMonthDayMinuteSecond(data.endTime)}已结拍";
    }

    if(data.bidStatus == 2){
      color = 0xffb28147;
    } else if(data.bidStatus == 3){
      color = 0xffc4301d;
    } else
      color = 0xff7e7e7e;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Color(color),
      child: new Container(
        padding: const EdgeInsets.only(left:10.0,top:5.0,right:10.0,bottom:5.0),
        child: new Text("$countDown",style: new TextStyle(fontSize: 11.0),),
      ),
      shape: RoundedRectangleBorder(side: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void deactivate(){
    super.deactivate();
    _cancelTimer();
  }

  Timer _timer;
  _startTimer() {
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
//         debugPrint("data.leftEndTime = ${data.leftEndTime}");
      setState(() {
        if(data.bidStatus == 2){
          countDown = getCountDownStatus2(data.leftStartTime, data.startTime);
        } else if(data.bidStatus == 3){
          countDown = getCountDownStatus3(data.leftEndTime, data.endTime);
        }
      });
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

}