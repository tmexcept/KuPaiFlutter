import 'dart:convert' show json;

class ClassConfigList {

  bool status;
  String code;
  String msg;
  List<ClassConfig> data;

  ClassConfigList.fromParams({this.status, this.code, this.msg, this.data});

  factory ClassConfigList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ClassConfigList.fromJson(json.decode(jsonStr)) : new ClassConfigList.fromJson(jsonStr);

  ClassConfigList.fromJson(jsonRes) {
    status = jsonRes['status'];
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new ClassConfig.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class ClassConfig {

  int classId;
  int configType;
  int skipType;
  String className;
  String icon;
  String pic;
  String skipUrl;
  String subtitle;
  String title;

  ClassConfig.fromParams({this.classId, this.configType, this.skipType, this.className, this.icon, this.pic, this.skipUrl, this.subtitle, this.title});

  ClassConfig.fromJson(jsonRes) {
    classId = jsonRes['classId'];
    configType = jsonRes['configType'];
    skipType = jsonRes['skipType'];
    className = jsonRes['className'];
    icon = jsonRes['icon'];
    pic = jsonRes['pic'];
    skipUrl = jsonRes['skipUrl'];
    subtitle = jsonRes['subtitle'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"classId": $classId,"configType": $configType,"skipType": $skipType,"className": ${className != null?'${json.encode(className)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"skipUrl": ${skipUrl != null?'${json.encode(skipUrl)}':'null'},"subtitle": ${subtitle != null?'${json.encode(subtitle)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

