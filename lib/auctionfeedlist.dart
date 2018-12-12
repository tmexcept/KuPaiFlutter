import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:flutterapp/httprequest.dart';
import 'package:flutterapp/realrichtext/real_rich_text.dart';

class AuctionFeedListShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AuctionFeedListState();
}

class AuctionFeedListState extends State<AuctionFeedListShow> {
  @override
  Widget build(BuildContext context) {
    print("========================");
    return new Scaffold(
      appBar: new AppBar(
        title: Text("show Feed Data"),
      ),
      //...
      body: boxAdapterWidget(context),
    );
  }

  List<Widget> showNickAddress(BidList data){
    List<Widget> widgets = [];
    widgets.add(Container(
        padding: EdgeInsets.only(left: 10.0,),
          child:Text(data.bidGoods.goodsName, style: TextStyle(fontSize: 15.0, color: Colors.white),overflow: TextOverflow.ellipsis, softWrap: false,
          ),
      )
    );
    if(data.onofflineExt != null && data.onofflineExt.location != null){
      widgets.add(
          Container(
              padding: EdgeInsets.only(left: 10.0,),
              child:Row(children: <Widget>[
                  Image(image: AssetImage("lib/image/icon_location_address.png"), width: 8.0, height: 18.0,),
                  Text(data.onofflineExt.location, style: TextStyle(fontSize: 11.0, color: Colors.white),overflow: TextOverflow.ellipsis, softWrap: false,),
                ],
              )
          )
      );
    }
    return widgets;
  }
  List<Widget> showLiveAttention(BidList data){
    List<Widget> widgets = [];
    widgets.add(Container(
        padding: EdgeInsets.only(right: 10.0,),
        child:Image(image: AssetImage("lib/image/icon_video.png"), width: 30.0, height: 30.0,
        )));
    widgets.add(Container(
        padding: EdgeInsets.only(right: 10.0,),
        child:Text("${data.browseNum}人关注", style: TextStyle(fontSize: 11.0, color: Colors.white),textAlign: TextAlign.right,)));
    return widgets;
  }

  Widget setAuctionFeedCover(BidList data){
    return new Container(
      constraints: BoxConstraints.expand(height: 235.0),//height: 235.0,如果不展示高度，Stack内部的布局容易错位
      decoration: new BoxDecoration(image: new DecorationImage(image: new NetworkImage(getAuctionFeedCover(data.bidGoods.pic)))),
      child: Stack(
        children: <Widget>[
//                    Image(image: new NetworkImage(getAuctionFeedCover(data.bidGoods.pic))),
          Positioned(child:Material(
            color: Color(0xffc4311d),
            child: new Container(
              padding: const EdgeInsets.only(left:10.0,top:5.0,right:10.0,bottom:5.0),
              child: new Text('倒计时',style: new TextStyle(fontSize: 11.0),),
            ),
            shape: RoundedRectangleBorder(side: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
          ),
            top: 10.0,
          ),
          Align(
            child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.only(top: 15.0),
                  constraints: BoxConstraints.expand(height: 75.0),
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Color(0xff000000), Color(0x000000)])),
                  child:new Row(children: <Widget>[
                    Expanded(child:Column(children: showNickAddress(data), crossAxisAlignment: CrossAxisAlignment.start,),),
                    Column(children: showLiveAttention(data), crossAxisAlignment: CrossAxisAlignment.end,),
                  ]
                  ),
                )
            ),
            alignment: AlignmentDirectional.bottomStart,
          ),
        ],
      ),
    );
  }

  Widget getPriceShow(BidList data){
    return Container(height: 50.0,
        alignment: AlignmentDirectional.center,
        child:Stack(children: <Widget>[
          Align(child:Row(children: <Widget>[
            new Text("起拍价￥${data.initialPrice}",
              style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,color: Color(0xffb28147),),
            ),
            new Text("保证金￥${data.initialPrice}",
              style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,color: Colors.black,),
            ),
          ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
            alignment: AlignmentDirectional.center,
          ),

          Align(child: Container(color: Colors.black,width: 1.0, height: 50.0,alignment: AlignmentDirectional.center,),)
        ],
        )
    );
  }

  Widget showVoice(BidList data){
    return Container(
      height: 50.0,
      child:Stack(
          children: <Widget>[
            Container(
              height: 35.0,
              width: 50.0,
              margin: EdgeInsets.only(left:10.0,top:10.0,right:10.0,bottom:10.0),
              decoration: BoxDecoration(color: Color(0xffb28147), borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)
              )),),
            Align(child:Container(
                padding: EdgeInsets.only(left: 25.0),
                child:Row(
                    children: <Widget>[
                      Image(image: AssetImage("lib/image/icon_audio3.png"), width: 10.0, height: 15.0,),
                      Container(padding: EdgeInsets.only(left: 5.0), child:Text("5'", style: TextStyle(color: Colors.white, fontSize: 11.0),),)
                    ]
                )
            ),alignment: AlignmentDirectional.centerStart,
            )
          ]),
    );
  }

  Widget getRecommendDesc(BidList data){
    return Container(padding: EdgeInsets.all(10.0),
        child:RealRichText([ImageSpan(
            AssetImage("lib/image/dis_left_quote.png"),
            imageWidth: 12.0,
            imageHeight: 10.0
        ),
        TextSpan(
          text: "data.bidGoods.recommendDesc",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),ImageSpan(
            AssetImage("lib/image/dis_right_quote.png"),
            imageWidth: 12.0,
            imageHeight: 10.0
        ),
        ])
    );
  }

  Widget listItem(context, index, BidList data) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Supplier supplier = data.bidGoods.supplier;
    return Container(
      margin: EdgeInsets.all(10.0),
        color: Color(0xff4a4a4a),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child:  new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRecommendUser(supplier, textTheme),
                setAuctionFeedCover(data),
                showVoice(data),
                getRecommendDesc(data),
                Container(height: 1.0,color: Colors.black,),
                getPriceShow(data),
              ],
            ),
        )
    );
  }


  Widget supplierTags(Supplier supplier, BuildContext context){
//    debugPrint("${supplier.tags}  ${supplier.tags.length}");
//    List<Chip> tags = [];
//    for(int i=0;i<supplier.tags.length;i++){
//      tags.add(Chip(
//        label: Text(supplier.tags[i], style: TextStyle(fontSize: 11.0),),
//        shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xffc4311d)), borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20))),
//        backgroundColor: Colors.white,
//        labelPadding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 0.0),
////        padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
//        )
//      );
//    }

    List<Material> tags = [];
    for(int i=0;i<supplier.tags.length && supplier.tags.length>0;i++){
      if(supplier.tags[i].isEmpty) continue;

      tags.add(Material(
        //背景色
//        color: Colors.amber,
        shape: new RoundedRectangleBorder(
          side: const BorderSide(
              width: 1.0,
              color: Color(0xffc4311d)
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(3.0),
            topRight: const Radius.circular(3.0),
            bottomLeft: const Radius.circular(3.0),
            bottomRight: const Radius.circular(3.0),
          )
        ),
        child: new Container(
          padding: EdgeInsets.only(left:5.0,top:0.0,right:5.0,bottom:2.0),
          child: new Text(supplier.tags[i],style: new TextStyle(fontSize: 11.0),),
        ),
      )
      );
    }
    return  Wrap(
      spacing: 5.0,
      runSpacing: 5.0,
      children: tags,
    );
  }

  Widget getPeopleAvater(Supplier supplier){
    return
      new Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[new CircleAvatar(
            backgroundImage: new NetworkImage(getUserAvater(supplier.supplierPic)),),
            Positioned(child: Image(image:  AssetImage(getSupplierLevel(supplier.level)), width: 18.0, height: 10.0,),
              right: 0.0,bottom: 0.0,
            ),
        ],
      ),
    );

//    return
//      new Container(
//        height: 50.0,
//        width: 50.0,
//        margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0, left: 10.0),
//        decoration: BoxDecoration(image: DecorationImage(image: new NetworkImage(getUserAvater(supplier.supplierPic))), borderRadius: BorderRadius.all(Radius.circular(100.0)) ),
//        child: Image(image:  AssetImage("lib/image/icon_video.png"), width: 5.0, height: 5.0,),
//      );
  }

  Widget getRecommendUser(Supplier supplier, TextTheme textTheme) {
    return
    Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/image/icon_supper_defoult_bg.webp"), fit: BoxFit.cover)),
//      constraints: BoxConstraints.expand(height: 50.0),
      child:new IntrinsicHeight(child:new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getPeopleAvater(supplier),
            Flexible(child: new Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(child: new Text("${supplier.supplierName}-测试能显示多少个汉字测试能显示多少个汉字",
                            style: TextStyle(fontSize: 15.0, color: Colors.black), overflow: TextOverflow.ellipsis, softWrap: true,),
                          ),
                          Offstage(offstage: supplier.strict != 1,
                            child: Image(image: AssetImage("lib/image/high_quality.png"),height: 16.0, width: 12.0,),),
                          Offstage(offstage: supplier.supplierType != 4,
                            child: Image(image: AssetImage("lib/image/icon_pai_blue.png"),height: 15.0, width: 15.0,),),
                      ]),
                  ),
                  supplierTags(supplier, context),
                ],
              ),
            ),
            ),
            new Container(
              width: 50.0,
              padding: EdgeInsets.only(left: 5.0),
              child:Image(image: AssetImage("lib/image/icon_arrow.png"),height: 10.0, width: 6.0,),
              alignment: AlignmentDirectional.centerStart,
            ),
          ],
        )
      )
    );
  }

  Widget boxAdapterWidget(context) {
    return FutureBuilder<List<BidList>>(
      future: fetchDetailEntity(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  listItem(context, index, snapshot.data[index]));
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
