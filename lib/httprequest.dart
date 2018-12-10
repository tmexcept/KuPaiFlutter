
import 'package:flutter/material.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


///请求网络获取数据并使用Json转换
Future<String> fetchDetail() async {
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString(); // unix时间戳 System.currentTime()/1000 获取
//  Map params = new Map();

//  const platform = const MethodChannel('flutter.io/sign');
//  Future<String> sign = platform.invokeMethod("sign", "timestamp");

//  "sign", NetCommUtil.signParams(params, timestamp)
  final response = await http.get("https://api.51kupai.com/kupai/feed/v3_list",
      headers: { "Accept-Encoding": "gzip","timestamp": timestamp,
        "_bkAccessToken_": "",
        "_tokenVersion_": "2",
        "sign": "",
        "_appType_": "2",
        "guestId": "",
        "kp-app-id": "10001",
        "APP_VERSION": "3.1.0",
        "APP_VERSION_CODE": "67",
        "APP_PLATFORM": "ANDROID",
        "CHANNEL_ID": "2010051014"});
  return response.body;
}

Future<List<BidList>> fetchDetailEntity(BuildContext context) async {
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString(); // unix时间戳 System.currentTime()/1000 获取
//  Map params = new Map();

//  const platform = const MethodChannel('flutter.io/sign');
//  Future<String> sign = platform.invokeMethod("sign", "timestamp");

//  "sign", NetCommUtil.signParams(params, timestamp)
  final response = await http.get("https://api.51kupai.com/kupai/feed/v3_list",
      headers: { "Accept-Encoding": "gzip","timestamp": timestamp,
        "_bkAccessToken_": "",
        "_tokenVersion_": "2",
        "sign": "",
        "_appType_": "2",
        "guestId": "",
        "kp-app-id": "10001",
        "APP_VERSION": "3.1.0",
        "APP_VERSION_CODE": "67",
        "APP_PLATFORM": "ANDROID",
        "CHANNEL_ID": "2010051014"});
  debugPrint("**************");
  AuctionFeedBean feedBean = AuctionFeedBean.fromJson(json.decode(response.body));

//  String data = await DefaultAssetBundle.of(context).loadString("lib/file/file.txt");
//  AuctionFeedBean feedBean = AuctionFeedBean.fromJson(json.decode(data));

  List<BidList> bidEntitys;

  if(feedBean.data != null  && feedBean.status){
    bidEntitys = [];
    List<FeedEntity> feedList = feedBean.data.feedList;
    int length = feedList.length;
    for(int i=0;i<length;i++){
      bidEntitys.addAll(feedList[i].themeInfo.bidsList);
    }
  }

//  return response.body;
  return bidEntitys;
}