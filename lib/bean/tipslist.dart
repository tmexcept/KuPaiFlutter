import 'dart:convert' show json;

class TipsList {

  bool status;
  String code;
  String msg;
  TipsData data;

  TipsList.fromParams({this.status, this.code, this.msg, this.data});

  factory TipsList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TipsList.fromJson(json.decode(jsonStr)) : new TipsList.fromJson(jsonStr);

  TipsList.fromJson(jsonRes) {
    status = jsonRes['status'];
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new TipsData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class TipsData {

  List<Tips> tips;

  TipsData.fromParams({this.tips});

  TipsData.fromJson(jsonRes) {
    tips = jsonRes['tips'] == null ? null : [];

    for (var tipsItem in tips == null ? [] : jsonRes['tips']){
      tips.add(tipsItem == null ? null : new Tips.fromJson(tipsItem));
    }
  }

  @override
  String toString() {
    return '{"tips": $tips}';
  }
}

class Tips {

  int id;
  int orderNum;
  int status;
  int tipsType;
  int yn;
  String createTime;
  String h5LinkUrl;
  String imageUrl;
  String imageUrlBig;
  String imageUrlNew;
  String linkUrl;
  String title;

  Tips.fromParams({this.id, this.orderNum, this.status, this.tipsType, this.yn, this.createTime, this.h5LinkUrl, this.imageUrl, this.imageUrlBig, this.imageUrlNew, this.linkUrl, this.title});

  Tips.fromJson(jsonRes) {
    id = jsonRes['id'];
    orderNum = jsonRes['orderNum'];
    status = jsonRes['status'];
    tipsType = jsonRes['tipsType'];
    yn = jsonRes['yn'];
    createTime = jsonRes['createTime'];
    h5LinkUrl = jsonRes['h5LinkUrl'];
    imageUrl = jsonRes['imageUrl'];
    imageUrlBig = jsonRes['imageUrlBig'];
    imageUrlNew = jsonRes['imageUrlNew'];
    linkUrl = jsonRes['linkUrl'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": $id,"orderNum": $orderNum,"status": $status,"tipsType": $tipsType,"yn": $yn,"createTime": ${createTime != null?'${json.encode(createTime)}':'null'},"h5LinkUrl": ${h5LinkUrl != null?'${json.encode(h5LinkUrl)}':'null'},"imageUrl": ${imageUrl != null?'${json.encode(imageUrl)}':'null'},"imageUrlBig": ${imageUrlBig != null?'${json.encode(imageUrlBig)}':'null'},"imageUrlNew": ${imageUrlNew != null?'${json.encode(imageUrlNew)}':'null'},"linkUrl": ${linkUrl != null?'${json.encode(linkUrl)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

