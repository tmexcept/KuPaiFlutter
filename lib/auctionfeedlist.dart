import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:flutterapp/httprequest.dart';

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

  Widget listItem(context, index, BidList data) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Supplier supplier = data.bidGoods.supplier;
    return Card(
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
    for(int i=0;i<supplier.tags.length;i++){
      tags.add(Material(
        //背景色
//        color: Colors.amber,
        shape: new StadiumBorder(
          side: const BorderSide(
              width: 1.0,
              color: Color(0xffc4311d)
          ),
        ),
        child: new Container(
          padding: EdgeInsets.only(left:10.0,top:3.0,right:10.0,bottom:5.0),
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

  Widget getRecommendUser(Supplier supplier, TextTheme textTheme) {
    return
      new IntrinsicHeight(child:new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(getUserAvater(supplier.supplierPic)),
    //            radius: 20.0,
              ),
            ),
            new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(supplier.supplierName, style: textTheme.subhead, overflow: TextOverflow.ellipsis, softWrap: false,),
                  supplierTags(supplier, context),
                ],
              ),
            )
          ],
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
