
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/bean/RecommendList.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:http/http.dart' as http;

Map<String, String> initHeaders(){
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//  Map params = new Map();

//  const platform = const MethodChannel('flutter.io/sign');
//  Future<String> sign = platform.invokeMethod("sign", "timestamp");

//  "sign", NetCommUtil.signParams(params, timestamp)

  return { "Accept-Encoding": "gzip","timestamp": timestamp,
  "_bkAccessToken_": "",
  "_tokenVersion_": "2",
  "sign": "",
  "_appType_": "2",
  "guestId": "",
  "kp-app-id": "10001",
  "APP_VERSION": "3.1.0",
  "APP_VERSION_CODE": "67",
  "APP_PLATFORM": "ANDROID",
  "CHANNEL_ID": "2010051014"};
}


///请求网络获取数据并使用Json转换
Future<String> fetchDetail() async {
  final response = await http.get("https://api.51kupai.com/kupai/feed/v3_list",
      headers: initHeaders());
  return response.body;
}


Future<List<BidList>> fetchDetailEntity(Map<String, String> headers) async {
//  headers.addAll(initHeaders());
  final response = await http.post("https://api.51kupai.com/kupai/feed/v3_list", headers: headers, body: headers);
  AuctionFeedBean feedBean = AuctionFeedBean.fromJson(json.decode(response.body));

//  String data = await DefaultAssetBundle.of(context).loadString("lib/file/file.txt");
//  AuctionFeedBean feedBean = AuctionFeedBean.fromJson(json.decode(data));

  debugPrint("****${response.body}");
  List<BidList> bidEntitys;

  if(feedBean.data != null  && feedBean.status){
    bidEntitys = [];
    List<FeedEntity> feedList = feedBean.data.feedList;
    int length = feedList.length;
    for(int i=0;i<length;i++){
      List<BidList> bids = feedList[i].themeInfo.bidsList;
      for(int j = 0;j<bids.length;j++){
        bids[j].localBackgroundType = feedList[i].themeInfo.backgroundType;
      }

      bidEntitys.addAll(bids);
    }
  }

  return bidEntitys;
}

Future<List<Recommend>> fetchRecommendThreeList(Map<String, String> headers) async {
//  headers.addAll(initHeaders());
  final response = await http.post("https://api.51kupai.com/kupai/feed/class/tag/recommend", headers: initHeaders(), body: headers);
  RecommendThreeList list = RecommendThreeList.fromJson(json.decode(response.body));
  debugPrint("RecommendThreeList = ${list.toString()}");
  return list.data;
}