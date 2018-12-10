import 'dart:convert' show json;
import 'package:flutter/material.dart';

class AuctionFeedBean {

  bool status;
  String code;
  String msg;
  FeedList data;

  AuctionFeedBean.fromParams({this.status, this.code, this.msg, this.data});

  factory AuctionFeedBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new AuctionFeedBean.fromJson(json.decode(jsonStr)) : new AuctionFeedBean.fromJson(jsonStr);

  AuctionFeedBean.fromJson(jsonRes) {
    status = jsonRes['status'];
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new FeedList.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class FeedList {

  List<FeedEntity> feedList;

  FeedList.fromParams({this.feedList});

  FeedList.fromJson(jsonRes) {
    feedList = jsonRes['feedList'] == null ? null : [];

    for (var feedListItem in feedList == null ? [] : jsonRes['feedList']){
      feedList.add(feedListItem == null ? null : new FeedEntity.fromJson(feedListItem));
    }
  }

  @override
  String toString() {
    return '{"feedList": $feedList}';
  }
}

class FeedEntity {

  int feedType;
  ThemeInfo themeInfo;

  FeedEntity.fromParams({this.feedType, this.themeInfo});

  FeedEntity.fromJson(jsonRes) {
    feedType = jsonRes['feedType'];
    themeInfo = jsonRes['themeInfo'] == null ? null : new ThemeInfo.fromJson(jsonRes['themeInfo']);
  }

  @override
  String toString() {
    return '{"feedType": $feedType,"themeInfo": $themeInfo}';
  }
}

class ThemeInfo {

  int backgroundType;
  int bidTotal;
  int classId;
  int foldFlag;
  int onLineIndex;
  int themeId;
  int themeScore;
  int themeType;
  String className;
  String themeIcon;
  String themeName;
  String themeTopPic;
  List<BidList> bidsList;

  ThemeInfo.fromParams({this.backgroundType, this.bidTotal, this.classId, this.foldFlag, this.onLineIndex, this.themeId, this.themeScore, this.themeType, this.className, this.themeIcon, this.themeName, this.themeTopPic, this.bidsList});

  ThemeInfo.fromJson(jsonRes) {
    backgroundType = jsonRes['backgroundType'];
    bidTotal = jsonRes['bidTotal'];
    classId = jsonRes['classId'];
    foldFlag = jsonRes['foldFlag'];
    onLineIndex = jsonRes['onLineIndex'];
    themeId = jsonRes['themeId'];
    themeScore = jsonRes['themeScore'];
    themeType = jsonRes['themeType'];
    className = jsonRes['className'];
    themeIcon = jsonRes['themeIcon'];
    themeName = jsonRes['themeName'];
    themeTopPic = jsonRes['themeTopPic'];
    bidsList = jsonRes['bidsList'] == null ? null : [];

    for (var bidsListItem in bidsList == null ? [] : jsonRes['bidsList']){
      bidsList.add(bidsListItem == null ? null : new BidList.fromJson(bidsListItem));
    }
  }

  @override
  String toString() {
    return '{"backgroundType": $backgroundType,"bidTotal": $bidTotal,"classId": $classId,"foldFlag": $foldFlag,"onLineIndex": $onLineIndex,"themeId": $themeId,"themeScore": $themeScore,"themeType": $themeType,"className": ${className != null?'${json.encode(className)}':'null'},"themeIcon": ${themeIcon != null?'${json.encode(themeIcon)}':'null'},"themeName": ${themeName != null?'${json.encode(themeName)}':'null'},"themeTopPic": ${themeTopPic != null?'${json.encode(themeTopPic)}':'null'},"bidsList": $bidsList}';
  }
}


class BidList {

  OnoffLineExt onofflineExt;
  double bailPrice;
  int bidStatus;
  int bidType;
  int browseNum;
  int buyBack;
  int endTime;
  int focusNum;
  int index;
  double initialPrice;
  int isOnoffline;
  int isVideoUrl;
  int leftEndTime;
  int leftStartTime;

  double lowerPrice;
  double maxPrice;
  int likeNum;
  int reBid;
  int redPacketBid;
  int saleId;
  int startTime;
  String H5BidDetailUrl;
  String dealPrice;
  String sign;
  BidGoods bidGoods;

  BidList.fromParams({this.onofflineExt, this.bailPrice, this.bidStatus, this.bidType, this.browseNum, this.buyBack, this.endTime, this.focusNum, this.index,
    this.initialPrice, this.isOnoffline, this.isVideoUrl, this.leftEndTime, this.leftStartTime, this.likeNum, this.lowerPrice, this.maxPrice, this.reBid, this.redPacketBid,
    this.saleId, this.startTime, this.H5BidDetailUrl, this.dealPrice, this.sign, this.bidGoods});

  BidList.fromJson(jsonRes) {
    onofflineExt = jsonRes['onofflineExt'] == null ? null : new OnoffLineExt.fromJson(jsonRes['onofflineExt']);
    bailPrice = jsonRes['bailPrice'];
    bidStatus = jsonRes['bidStatus'];
    bidType = jsonRes['bidType'];
    browseNum = jsonRes['browseNum'];
    buyBack = jsonRes['buyBack'];
    endTime = jsonRes['endTime'];
    focusNum = jsonRes['focusNum'];
    index = jsonRes['index'];
    initialPrice = jsonRes['initialPrice'];
    isOnoffline = jsonRes['isOnoffline'];
    isVideoUrl = jsonRes['isVideoUrl'];
    leftEndTime = jsonRes['leftEndTime'];
    leftStartTime = jsonRes['leftStartTime'];
    likeNum = jsonRes['likeNum'];
    num lower = jsonRes['lowerPrice'];
    lowerPrice = lower.toDouble();
    num max = jsonRes['maxPrice'];
    maxPrice = max.toDouble();
    reBid = jsonRes['reBid'];
    redPacketBid = jsonRes['redPacketBid'];
    saleId = jsonRes['saleId'];
    startTime = jsonRes['startTime'];
    H5BidDetailUrl = jsonRes['H5BidDetailUrl'];
    dealPrice = jsonRes['dealPrice'];
    sign = jsonRes['sign'];
    bidGoods = jsonRes['bidGoods'] == null ? null : new BidGoods.fromJson(jsonRes['bidGoods']);
  }

  @override
  String toString() {
    return '{"onofflineExt": $onofflineExt,"bailPrice": $bailPrice,"bidStatus": $bidStatus,"bidType": $bidType,"browseNum": $browseNum,"buyBack": $buyBack,"endTime": $endTime,"focusNum": $focusNum,"index": $index,'
        '"initialPrice": $initialPrice,"isOnoffline": $isOnoffline,"isVideoUrl": $isVideoUrl,"leftEndTime": $leftEndTime,"leftStartTime": $leftStartTime,"likeNum": $likeNum,'
        '"lowerPrice": $lowerPrice,"maxPrice": $maxPrice,"reBid": $reBid,"redPacketBid": $redPacketBid,"saleId": $saleId,"startTime": $startTime,"H5BidDetailUrl": ${H5BidDetailUrl != null?'${json.encode(H5BidDetailUrl)}':'null'},"dealPrice": ${dealPrice != null?'${json.encode(dealPrice)}':'null'},"sign": ${sign != null?'${json.encode(sign)}':'null'},"bidGoods": $bidGoods}';
  }
}

class OnoffLineExt {

  int dateExpectSale;
  int saleId;
  double locationLat;
  double locationLon;
  String h5Link;
  String location;
  String weChatAppId;

  OnoffLineExt.fromParams({this.dateExpectSale, this.saleId, this.locationLat, this.locationLon, this.h5Link, this.location, this.weChatAppId});

  OnoffLineExt.fromJson(jsonRes) {
    dateExpectSale = jsonRes['dateExpectSale'];
    saleId = jsonRes['saleId'];
    locationLat = jsonRes['locationLat'];
    locationLon = jsonRes['locationLon'];
    h5Link = jsonRes['h5Link'];
    location = jsonRes['location'];
    weChatAppId = jsonRes['weChatAppId'];
  }

  @override
  String toString() {
    return '{"dateExpectSale": $dateExpectSale,"saleId": $saleId,"locationLat": ${location != null?'${json.encode(location)}':'null'},"locationLon": ${location != null?'${json.encode(location)}':'null'},"h5Link": ${h5Link != null?'${json.encode(h5Link)}':'null'},"location": ${location != null?'${json.encode(location)}':'null'},"weChatAppId": ${weChatAppId != null?'${json.encode(weChatAppId)}':'null'}}';
  }
}


class BidGoods {

  String recommendDesc;
  Recommenduser recommenduser;
  int isBindSupplier;
  int isRecommend;
  int recommendAudioTime;
  int recommendAuthStatus;
  int recommendUid;
  String goodsName;
  String pic;
  String recommendAudioUrl;
  String recommendAuthText;
  String recommendName;
  String recommendPic;
  String supplierName;
  Supplier supplier;

  BidGoods.fromParams({this.recommendDesc, this.recommenduser, this.isBindSupplier, this.isRecommend, this.recommendAudioTime, this.recommendAuthStatus, this.recommendUid, this.goodsName, this.pic, this.recommendAudioUrl, this.recommendAuthText, this.recommendName, this.recommendPic, this.supplierName, this.supplier});

  BidGoods.fromJson(jsonRes) {
    recommendDesc = jsonRes['recommendDesc'];
    recommenduser = jsonRes['recommenduser'] == null ? null : new Recommenduser.fromJson(jsonRes['recommenduser']);
    isBindSupplier = jsonRes['isBindSupplier'];
    isRecommend = jsonRes['isRecommend'];
    recommendAudioTime = jsonRes['recommendAudioTime'];
    recommendAuthStatus = jsonRes['recommendAuthStatus'];
    recommendUid = jsonRes['recommendUid'];
    goodsName = jsonRes['goodsName'];
    pic = jsonRes['pic'];
    recommendAudioUrl = jsonRes['recommendAudioUrl'];
    recommendAuthText = jsonRes['recommendAuthText'];
    recommendName = jsonRes['recommendName'];
    recommendPic = jsonRes['recommendPic'];
    supplierName = jsonRes['supplierName'];
    supplier = jsonRes['supplier'] == null ? null : new Supplier.fromJson(jsonRes['supplier']);
  }

  @override
  String toString() {
    return '{"recommendDesc": ${recommendDesc != null?'${json.encode(recommendDesc)}':'null'},"recommenduser": ${recommenduser != null?'${json.encode(recommenduser)}':'null'},"isBindSupplier": $isBindSupplier,"isRecommend": $isRecommend,"recommendAudioTime": $recommendAudioTime,"recommendAuthStatus": $recommendAuthStatus,"recommendUid": $recommendUid,"goodsName": ${goodsName != null?'${json.encode(goodsName)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"recommendAudioUrl": ${recommendAudioUrl != null?'${json.encode(recommendAudioUrl)}':'null'},"recommendAuthText": ${recommendAuthText != null?'${json.encode(recommendAuthText)}':'null'},"recommendName": ${recommendName != null?'${json.encode(recommendName)}':'null'},"recommendPic": ${recommendPic != null?'${json.encode(recommendPic)}':'null'},"supplierName": ${supplierName != null?'${json.encode(supplierName)}':'null'},"supplier": $supplier}';
  }
}

class Supplier {

  int level;
  int strict;
  int suppAuthStatus;
  int supplierIsBindSupplier;
  int supplierType;
  String backgroundImg;
  String grade;
  String suppAuthText;
  String supplierId;
  String supplierName;
  String supplierPic;
  List<String> tags;

  Supplier.fromParams({this.level, this.strict, this.suppAuthStatus, this.supplierIsBindSupplier, this.supplierType, this.backgroundImg, this.grade, this.suppAuthText, this.supplierId, this.supplierName, this.supplierPic, this.tags});

  Supplier.fromJson(jsonRes) {
    level = jsonRes['level'];
    strict = jsonRes['strict'];
    suppAuthStatus = jsonRes['suppAuthStatus'];
    supplierIsBindSupplier = jsonRes['supplierIsBindSupplier'];
    supplierType = jsonRes['supplierType'];
    backgroundImg = jsonRes['backgroundImg'];
    grade = jsonRes['grade'];
    suppAuthText = jsonRes['suppAuthText'];
    supplierId = jsonRes['supplierId'];
    supplierName = jsonRes['supplierName'];
    supplierPic = jsonRes['supplierPic'];
    debugPrint("${jsonRes['tags']}");
    tags = jsonRes['tags'].toString().split(",");
  }

  @override
  String toString() {
    return '{"level": $level,"strict": $strict,"suppAuthStatus": $suppAuthStatus,"supplierIsBindSupplier": $supplierIsBindSupplier,"supplierType": $supplierType,"backgroundImg": ${backgroundImg != null?'${json.encode(backgroundImg)}':'null'},"grade": ${grade != null?'${json.encode(grade)}':'null'},"suppAuthText": ${suppAuthText != null?'${json.encode(suppAuthText)}':'null'},"supplierId": ${supplierId != null?'${json.encode(supplierId)}':'null'},"supplierName": ${supplierName != null?'${json.encode(supplierName)}':'null'},"supplierPic": ${supplierPic != null?'${json.encode(supplierPic)}':'null'},"tags": ${tags != null?'${json.encode(tags)}':'null'}}';
  }
}

class Recommenduser {
  int isRecommend ; //是否推荐人
  int isBindSupplier; //是否机构
  String recommendPic; // 头像
  String recommendDesc; //推荐描述
  String recommendName;//推荐人名称
  String recommendAuthText; //认证信息
  int recommendAuthStatus;// 认证状态
  String recommendUid ;//推荐人id
  int recommendAudioTime ;//推荐语音时长
  String recommendAudioUrl; //推荐语音地址

  Recommenduser.fromParam({this.isRecommend, this.isBindSupplier, this.recommendPic,this.recommendDesc, this.recommendName,
    this.recommendAuthText, this.recommendAuthStatus, this.recommendUid, this.recommendAudioTime, this.recommendAudioUrl});

  Recommenduser.fromJson(jsonRes){
    isRecommend = jsonRes['isRecommend'];
    isBindSupplier = jsonRes['isBindSupplier'];
    recommendPic = jsonRes['recommendPic'];
    recommendDesc = jsonRes['recommendDesc'];
    recommendName = jsonRes['recommendName'];
    recommendAuthText = jsonRes['recommendAuthText'];
    recommendAuthStatus = jsonRes['recommendAuthStatus'];
    recommendUid = jsonRes['recommendUid'];
    recommendAudioTime = jsonRes['recommendAudioTime'];
    recommendAudioUrl = jsonRes['recommendAudioUrl'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

String getUserAvater(String picUrl){
//  debugPrint("recommendPic = ${picUrl}");

  if(picUrl == null)
    return "https://img.51kupai.com/pic/webp/110-110-a2cb7ad70785b08959031a251e0d328a/0";
  else if(picUrl.startsWith("http://")||picUrl.startsWith("https://")){
    return picUrl;
  }
  return "https://img.51kupai.com/pic/webp/${picUrl}/200";
}
String getAuctionFeedCover(String pic){
  List<String> pics = pic.split(",");
  String cover = getPhotoUrl(pics[0], 500);
  debugPrint("cover = ${cover}");
  return cover;
}

String IMAGE_BASE_URL = "https://img.51kupai.com/pic/webp/";
String getPhotoUrl(String picid, int size) {
  if(picid.isEmpty) return "";

  if(picid.startsWith("http://")||picid.startsWith("https://")) {
    if (picid.startsWith("http://img.51baoku.com/pic/")) {
      picid = picid.replaceFirst("http://img.51baoku.com/pic/", IMAGE_BASE_URL);
      return picid;
    } else if (picid.startsWith("https://img.51baoku.com/pic/")) {
      picid = picid.replaceFirst("https://img.51baoku.com/pic/", IMAGE_BASE_URL);
      return picid;
    }
    return picid;
  }
  return IMAGE_BASE_URL + picid + "/" + size.toString();
}
