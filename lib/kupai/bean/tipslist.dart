import 'dart:convert' show json;

class TipsList {

  late bool status;
  late String code;
  late String msg;
  late TipsData data;

  TipsList.fromParams({required this.status, required this.code, required this.msg, required this.data});

  factory TipsList(jsonStr) => jsonStr ? new TipsList.fromJson(json.decode(jsonStr)) : new TipsList.fromJson(jsonStr);

  TipsList.fromJson(jsonRes) {
    status = jsonRes['status'];
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = (jsonRes['data'] == null ? null : new TipsData.fromJson(jsonRes['data']))!;
  }

  @override
  String toString() {
    return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class TipsData {

  late List<Tips> tips;

  TipsData.fromParams({required this.tips});

  TipsData.fromJson(jsonRes) {
    tips = [];

    for (var tipsItem in tips == null ? [] : jsonRes['tips']){
      tips.add(new Tips.fromJson(tipsItem));
    }
  }

  @override
  String toString() {
    return '{"tips": $tips}';
  }
}

class Tips {

  late int id;
  late int orderNum;
  late int status;
  late int tipsType;
  late int yn;
  late String createTime;
  late String h5LinkUrl;
  late String imageUrl;
  late String imageUrlBig;
  late String imageUrlNew;
  late String linkUrl;
  late String title;

  Tips.fromParams({required this.id,
    required this.orderNum,
    required this.status,
    required this.tipsType,
    required this.yn,
    required this.createTime,
    required this.h5LinkUrl,
    required this.imageUrl,
    required this.imageUrlBig,
    required this.imageUrlNew,
    required this.linkUrl,
    required this.title});

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

