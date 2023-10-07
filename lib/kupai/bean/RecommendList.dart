// import 'dart:convert' show json;
//
// class RecommendThreeList {
//
//   bool status;
//   String code;
//   String msg;
//   List<Recommend> data;
//
//   RecommendThreeList.fromParams({this.status, this.code, this.msg, this.data});
//
//   factory RecommendThreeList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RecommendThreeList.fromJson(json.decode(jsonStr)) : new RecommendThreeList.fromJson(jsonStr);
//
//   RecommendThreeList.fromJson(jsonRes) {
//     status = jsonRes['status'];
//     code = jsonRes['code'];
//     msg = jsonRes['msg'];
//     data = jsonRes['data'] == null ? null : [];
//
//     for (var dataItem in data == null ? [] : jsonRes['data']){
//       data.add(dataItem == null ? null : new Recommend.fromJson(dataItem));
//     }
//   }
//
//   @override
//   String toString() {
//     return '{"status": $status,"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
//   }
// }
//
// class Recommend {
// //  public String icon;//角标
// //  public String pic;//图片
// //  public String cover;//图片3.0.5版本
// //  public String subtitle;//介绍
// //  public String desc;//介绍3.0.5版本
// //  public String title;// Id
// //  public String className;// 品牌名称
// //  public String skipUrl;//连接
// //  public String link;//连接3.0.5版本
// //  public int classId;//品牌id
// //  public int position;//分类
// //  public int type;//分类 类型 1：分类 2：链接",
//
//   int classId;
//   int position;
//   int type;
//   String className;
//   String cover;
//   String desc;
//   String icon;
//   String link;
//   String title;
//
//   Recommend.fromParams({this.classId, this.position, this.type, this.className, this.cover, this.desc, this.icon, this.link, this.title});
//
//   Recommend.fromJson(jsonRes) {
//     classId = jsonRes['classId'];
//     position = jsonRes['position'];
//     type = jsonRes['type'];
//     className = jsonRes['className'];
//     cover = jsonRes['cover'];
//     desc = jsonRes['desc'];
//     icon = jsonRes['icon'];
//     link = jsonRes['link'];
//     title = jsonRes['title'];
//   }
//
//   @override
//   String toString() {
//     return '{"classId": $classId,"position": $position,"type": $type,"className": ${className != null?'${json.encode(className)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
//   }
// }
//
