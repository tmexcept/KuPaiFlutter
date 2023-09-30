// import 'dart:convert' show json;
//
// class AuctionFeedBean {
//
//   bool status;
//   String code;
//   String msg;
//   FeedList data;
//
//   AuctionFeedBean.fromParams({this.status, this.code, this.msg, this.data});
//
//   factory AuctionFeedBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new AuctionFeedBean.fromJson(json.decode(jsonStr)) : new AuctionFeedBean.fromJson(jsonStr);
//
//   AuctionFeedBean.fromJson(jsonRes) {
//     status = jsonRes['status'];
//     code = jsonRes['code'];
//     msg = jsonRes['msg'];
//     data = jsonRes['data'] == null ? null : new FeedList.fromJson(jsonRes['data']);
//   }
//
//   @override
//   String toString() {
//     return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
//   }
// }
//
// class FeedList {
//
//   List<FeedEntity> feedList;
//
//   FeedList.fromParams({this.feedList});
//
//   FeedList.fromJson(jsonRes) {
//     feedList = jsonRes['feedList'] == null ? null : [];
//
//     for (var feedListItem in feedList == null ? [] : jsonRes['feedList']){
//       feedList.add(feedListItem == null ? null : new FeedEntity.fromJson(feedListItem));
//     }
//   }
//
//   @override
//   String toString() {
//     return '{"feedList": $feedList}';
//   }
// }
//
// class FeedEntity {
//
//   int feedType;
//   ThemeInfo themeInfo;
//
//   FeedEntity.fromParams({this.feedType, this.themeInfo});
//
//   FeedEntity.fromJson(jsonRes) {
//     feedType = jsonRes['feedType'];
//     themeInfo = jsonRes['themeInfo'] == null ? null : new ThemeInfo.fromJson(jsonRes['themeInfo']);
//   }
//
//   @override
//   String toString() {
//     return '{"feedType": $feedType,"themeInfo": $themeInfo}';
//   }
// }
//
// class ThemeInfo {
//
//   int backgroundType;
//   int bidTotal;
//   int classId;
//   int foldFlag;
//   int onLineIndex;
//   int themeId;
//   int themeScore;
//   int themeType;
//   String className;
//   String themeIcon;
//   String themeName;
//   String themeTopPic;
//   List<BidList> bidsList;
//
//   ThemeInfo.fromParams({this.backgroundType, this.bidTotal, this.classId, this.foldFlag, this.onLineIndex, this.themeId, this.themeScore, this.themeType, this.className, this.themeIcon, this.themeName, this.themeTopPic, this.bidsList});
//
//   ThemeInfo.fromJson(jsonRes) {
//     backgroundType = jsonRes['backgroundType'];
//     bidTotal = jsonRes['bidTotal'];
//     classId = jsonRes['classId'];
//     foldFlag = jsonRes['foldFlag'];
//     onLineIndex = jsonRes['onLineIndex'];
//     themeId = jsonRes['themeId'];
//     themeScore = jsonRes['themeScore'];
//     themeType = jsonRes['themeType'];
//     className = jsonRes['className'];
//     themeIcon = jsonRes['themeIcon'];
//     themeName = jsonRes['themeName'];
//     themeTopPic = jsonRes['themeTopPic'];
//     bidsList = jsonRes['bidsList'] == null ? null : [];
//
//     for (var bidsListItem in bidsList == null ? [] : jsonRes['bidsList']){
//       bidsList.add(bidsListItem == null ? null : new BidList.fromJson(bidsListItem));
//     }
//   }
//
//   @override
//   String toString() {
//     return '{"backgroundType": $backgroundType,"bidTotal": $bidTotal,"classId": $classId,"foldFlag": $foldFlag,"onLineIndex": $onLineIndex,"themeId": $themeId,"themeScore": $themeScore,"themeType": $themeType,"className": ${className != null?'${json.encode(className)}':'null'},"themeIcon": ${themeIcon != null?'${json.encode(themeIcon)}':'null'},"themeName": ${themeName != null?'${json.encode(themeName)}':'null'},"themeTopPic": ${themeTopPic != null?'${json.encode(themeTopPic)}':'null'},"bidsList": $bidsList}';
//   }
// }
//
//
// class BidList {
//
//   OnoffLineExt onofflineExt;
//   int bailPrice;
//   int bidStatus;
//   int bidType;
//   int browseNum;
//   int buyBack;
//   int endTime;
//   int focusNum;
//   int likeNum;
//   int reBid;
//   int redPacketBid;
//   String H5BidDetailUrl;
//   String dealPrice;
//   String sign;
//
//   BidList.fromParams({this.onofflineExt, this.bailPrice, this.bidStatus, this.bidType, this.browseNum, this.buyBack,
//     this.likeNum, this.reBid, this.redPacketBid, this.H5BidDetailUrl, this.dealPrice, this.sign});
//
//   BidList.fromJson(jsonRes) {
//     onofflineExt = jsonRes['onofflineExt'] == null ? null : new OnoffLineExt.fromJson(jsonRes['onofflineExt']);
//     bailPrice = jsonRes['bailPrice'];
//     bidStatus = jsonRes['bidStatus'];
//     bidType = jsonRes['bidType'];
//     browseNum = jsonRes['browseNum'];
//     buyBack = jsonRes['buyBack'];
//
//     likeNum = jsonRes['likeNum'];
//     reBid = jsonRes['reBid'];
//     redPacketBid = jsonRes['redPacketBid'];
//     H5BidDetailUrl = jsonRes['H5BidDetailUrl'];
//     dealPrice = jsonRes['dealPrice'];
//     sign = jsonRes['sign'];
//   }
//
//   @override
//   String toString() {
//     return '{"onofflineExt": $onofflineExt,"bailPrice": $bailPrice,"bidStatus": $bidStatus,"bidType": $bidType,"browseNum": $browseNum,"buyBack": $buyBack,'
//         ''
//         '"likeNum": $likeNum,"reBid": $reBid,"redPacketBid": $redPacketBid,"H5BidDetailUrl": ${H5BidDetailUrl != null?'${json.encode(H5BidDetailUrl)}':'null'},"dealPrice": ${dealPrice != null?'${json.encode(dealPrice)}':'null'},"sign": ${sign != null?'${json.encode(sign)}':'null'}}';
//   }
// }
//
// class OnoffLineExt {
//
//   int dateExpectSale;
//   int saleId;
//   double locationLat;
//   double locationLon;
//   String h5Link;
//   String location;
//   String weChatAppId;
//
//   OnoffLineExt.fromParams({this.dateExpectSale, this.saleId, this.locationLat, this.locationLon, this.h5Link, this.location, this.weChatAppId});
//
//   OnoffLineExt.fromJson(jsonRes) {
//     dateExpectSale = jsonRes['dateExpectSale'];
//     saleId = jsonRes['saleId'];
//     locationLat = jsonRes['locationLat'];
//     locationLon = jsonRes['locationLon'];
//     h5Link = jsonRes['h5Link'];
//     location = jsonRes['location'];
//     weChatAppId = jsonRes['weChatAppId'];
//   }
//
//   @override
//   String toString() {
//     return '{"dateExpectSale": $dateExpectSale,"saleId": $saleId,"locationLat": ${location != null?'${json.encode(location)}':'null'},"locationLon": ${location != null?'${json.encode(location)}':'null'},"h5Link": ${h5Link != null?'${json.encode(h5Link)}':'null'},"location": ${location != null?'${json.encode(location)}':'null'},"weChatAppId": ${weChatAppId != null?'${json.encode(weChatAppId)}':'null'}}';
//   }
// }
