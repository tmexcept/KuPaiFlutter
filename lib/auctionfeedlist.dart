import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/auctionlistitem.dart';
import 'package:flutterapp/bean/RecommendList.dart';
import 'package:flutterapp/bean/bean_auctionfeed.dart';
import 'package:flutterapp/httprequest.dart';
import 'package:flutterapp/realrichtext/real_rich_text.dart';

class AuctionFeedListShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AuctionFeedListState();
}

class AuctionFeedListState extends State<AuctionFeedListShow> {

  static const int colorAssitRed = 0xffc4311d;
  static const int colorMain = 0xffb28147;
  static const int colorDayDevider = 0xffe8eff3;
  static const int colorDayBg = 0xffffffff;
  static const int colorDayTextMain = 0xff000000;
  static const int colorDayTextAssit = 0xff666666;

  static const int colorNightDivider = 0xff4a4a4a;
  static const int colorNightBg = 0xff2b0601;
  static const int colorNightTextMain = 0xffffffff;
  static const int colorNightTextAssit = 0xff999999;

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  Widget build(BuildContext context) {
    print("build========================");
    return new Scaffold(
      appBar: new AppBar(
        title: Text("show Feed Data"),
      ),
      //...
      body: boxAdapterWidget(context),
    );
  }

  @override
  void initState(){
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isPerformingRequest){
        print("maxScrollExtent========================");
        getDetailEntity(++_page);
      }
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    _cancelTimer();
    super.dispose();
  }

  Timer _timer;
  _startTimer() {
    //https://www.jianshu.com/p/f7a9b8c84d26
    if(_timer != null && _timer.isActive) return;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      BidList bidInfo;
      for(int i=0;i<bidList.length;i++){
        bidInfo = bidList[i];
        if (bidInfo.bidStatus == 2) {
          if (bidInfo.leftStartTime >= 0) {
            bidInfo.leftStartTime -= 1;
            bidInfo.leftEndTime -= 1;
          } else {
            bidInfo.leftEndTime -= 1;
          }
        } else if (bidInfo.bidStatus == 3) {
          if (bidInfo.leftEndTime >= 0) {
            bidInfo.leftEndTime -= 1;
          }
        }
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  List<Widget> showNickAddress(BidList data){
    List<Widget> widgets = [];
    widgets.add(Text(data.bidGoods.goodsName, style: TextStyle(fontSize: 15.0, color: Colors.white),overflow: TextOverflow.ellipsis, softWrap: false,));

    if(data.onofflineExt != null && data.onofflineExt.location != null){
      widgets.add(Row(children: <Widget>[
        Image(image: AssetImage("lib/image/icon_location_address.png"), width: 8.0, height: 18.0,),
        Text(data.onofflineExt.location, style: TextStyle(fontSize: 11.0, color: Colors.white),overflow: TextOverflow.ellipsis, softWrap: false,),
      ],
      )
      );
    }
    return widgets;
  }
  List<Widget> showLiveAttention(BidList data){
    List<Widget> widgets = [];
    if(data.isVideoUrl == 1)
      widgets.add(Image(image: AssetImage("lib/image/icon_video.png"), width: 30.0, height: 30.0,));
    widgets.add(Text("${data.browseNum}人关注", style: TextStyle(fontSize: 11.0, color: Colors.white),textAlign: TextAlign.right,));
    return widgets;
  }

  Widget setAuctionFeedCover(BidList data){
    return new Container(
      constraints: BoxConstraints.expand(height: 235.0),//height: 235.0,如果不展示高度，Stack内部的布局容易错位
//      decoration: new BoxDecoration(image: new DecorationImage(image: new NetworkImage(getAuctionFeedCover(data.bidGoods.pic)))),
      child: Stack(
        children: <Widget>[
          Container(constraints:BoxConstraints.expand(),child: Image(image: new NetworkImage(getAuctionFeedCover(data.bidGoods.pic)), fit: BoxFit.fill,)),
          Positioned(child: new AuctionListItemWidget(data: data),top: 10.0,),
          Align(
            child: Container(
              padding: EdgeInsets.only(top: 15.0, left: 10, right: 10,bottom: 2.0),
              constraints: BoxConstraints.expand(height: 65.0),
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Color(0xff000000), Color(0x000000)])),
              child:new Row(
                  children: <Widget>[
                    Expanded(child:Column(children: showNickAddress(data),crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,),),
                    Column(children: showLiveAttention(data), crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,),
                  ]
              ),
            ),
            alignment: AlignmentDirectional.bottomStart,
          ),
        ],
      ),
    );
  }

  Widget getPriceShow(BidList data){
    String leftPrice;
    String rightPrice;
    int leftColor;

    if(data.bidStatus == 2){
      leftPrice = "起拍价￥${data.initialPrice}";
      leftColor = colorMain;
      rightPrice = "保证金￥${data.bailPrice}";
    } else if(data.bidStatus == 3){
      leftPrice = "起拍价￥${data.initialPrice}";
      rightPrice = "当前价￥${data.maxPrice}";
      leftColor = colorAssitRed;
    } else if (data.bidStatus == 8 || data.bidStatus == 9 || data.bidStatus == 10) {
      leftPrice = "保证金￥${data.bailPrice}";
      rightPrice = "起拍价￥${data.initialPrice}";
      leftColor = colorMain;
    } else {
      leftPrice = "成交价￥${data.dealPrice}";
      leftColor = colorAssitRed;
      rightPrice = "最高出价￥${data.maxPrice}";

    }

    return Container(height: 50.0,
        alignment: AlignmentDirectional.center,
        child:Stack(children: <Widget>[
          Align(child:Row(children: <Widget>[
            new Text(leftPrice,
              style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,color: Color(leftColor),),
            ),
            new Text(rightPrice,
              style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,color: Color(data.localBackgroundType == 1 ? colorDayTextMain : colorNightTextMain),),
            ),
          ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
            alignment: AlignmentDirectional.center,
          ),

          Align(child: Container(color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),
            width: 1.0, height: 20.0,alignment: AlignmentDirectional.center,),)
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

  Widget getRecommendDesc(String recommendDesc){
    return Container(padding: EdgeInsets.all(10.0),
        child:RealRichText([
          ImageSpan(
              AssetImage("lib/image/dis_left_quote.png"),
              imageWidth: 12.0,
              imageHeight: 10.0
          ),
          TextSpan(
            text: recommendDesc,
            style: TextStyle(fontSize: 14, color: Colors.black,),
          ),ImageSpan(
              AssetImage("lib/image/dis_right_quote.png"),
              imageWidth: 12.0,
              imageHeight: 10.0
          ),
        ],
          maxLines: 2,
          overflow:TextOverflow.ellipsis,
        )
    );
  }

  List<Widget> getListViewItems(BidList data, BuildContext context){
    List<Widget> items = [];
    if(data.bidGoods.supplier != null){
      items.add(getRecommendUser(data.bidGoods.supplier, context));
    }
    items.add(setAuctionFeedCover(data));
    if(data.bidGoods.recommenduser != null){
      if(data.bidGoods.recommenduser.recommendAudioTime != null){
        items.add(showVoice(data));
      }
      if(data.bidGoods.recommenduser.recommendDesc != null){
        items.add(getRecommendDesc(data.bidGoods.recommenduser.recommendDesc));
      }
    }
    items.add(Container(height: 0.5,color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),),);
    items.add(getPriceShow(data));
    return items;
  }

  Widget listItem(context, index, BidList data) {
    _startTimer();

    return Container(
        padding: EdgeInsets.all(10.0),
        color: Color(data.localBackgroundType == 1 ? colorDayBg : colorNightBg),
        child:  Container(
          decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),width: 1),
                top: BorderSide(color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),width: 1),
                right: BorderSide(color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),width: 1),
                bottom: BorderSide(color: Color(data.localBackgroundType == 1 ? colorDayDevider : colorNightDivider),width: 1),
              )
          ),
          child:  new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: getListViewItems(data, context),
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
                color: Color(colorAssitRed)
            ),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(3.0),
              topRight: const Radius.circular(3.0),
              bottomLeft: const Radius.circular(3.0),
              bottomRight: const Radius.circular(3.0),
            )
        ),
        child: new Container(
          padding: EdgeInsets.only(left:5.0,top:1.0,right:5.0,bottom:1.0),
          child: new Text(supplier.tags[i],style: new TextStyle(fontSize: 9.0, color: Color(colorAssitRed)),),
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

  Widget getRecommendUser(Supplier supplier, BuildContext context) {
    return GestureDetector(
      child: showRecommendUser(supplier),
      onTap: (){
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("点击了${supplier.supplierName}"),
        ));
      },
    );
  }

  Widget showRecommendUser(Supplier supplier) {
    return Container(
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
                          Flexible(child: new Text(supplier.supplierName,
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

  List<BidList> bidList = [];
  getDetailEntity(int page) {
    if(isPerformingRequest) return;

    setState(() {
      isPerformingRequest = true;
      if(page == 1) {
        this.bidList.clear();
      }
    });
    Completer<Null> completer = new Completer<Null>();

    Map<String, String> headers = {"page":page.toString(), "pageSize":"10"};
    new Future(() => fetchDetailEntity(headers))
        .then((bids){
      completer.complete();
          if(!mounted) return;
          setState(() {
            isPerformingRequest = false;

//            if(page == 1) {
//              this.bidList = bids;
//            } else
              this.bidList.addAll(bids);
          });
    });
  }

  Future<Null> getDetailEntityFirst() async {
    _page = 1;
    getDetailEntity(_page);
    return;
  }

  int _page = 1;
  int addElse = 1;

  Widget boxAdapterWidget(context) {
    if(recommendTwo.length != 0)
      addElse = 2;

    if(bidList == null || bidList.isEmpty){
      _page = 1;
      getRecommendTwo();
      getDetailEntity(_page);
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        child:RefreshIndicator(child: ListView.builder(
          itemCount: bidList.length + addElse,
          itemBuilder: (context, index) {
            if(addElse == 2 && index == 0){
              return new Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildHead(),
              );
            } else if(index == bidList.length+addElse - 1)
              return _buildProgressIndicator();
            else {
              int position = index + addElse - 1;
              return listItem(context, position, bidList[position]);
            }
          },
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
        ),
        onRefresh: (){
          return getDetailEntityFirst();
        },
      )
      );
    }

//    return FutureBuilder<List<BidList>>(
//      future: fetchDetailEntity(),
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return ListView.builder(
//              itemCount: snapshot.data.length,
//              itemBuilder: (context, index) =>
//                  listItem(context, index, snapshot.data[index]));
//        } else if (snapshot.hasError) {
//          return Center(child: Text('${snapshot.error}'));
//        }
//        return Center(child: CircularProgressIndicator());
//      },
//    );
  }

  Widget _buildProgressIndicator(){
    return new Padding(padding: const EdgeInsets.all(10.0),
      child: new Center(
        child: Opacity(opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),

      ),
    );
  }

  List<Widget> _buildHead(){
    List<Widget> widgets = [];
    if(recommendTwo.length > 0){
      widgets.add(new GridView.count(crossAxisCount: 2,
        primary: false,
        childAspectRatio: 2.5,
        crossAxisSpacing: 5.0,
        children: _buildRecommend(),
        shrinkWrap: true,
      ));
    }
    return widgets;
  }

  List<Widget> _buildRecommend(){
    List<Widget> widgets = [];
    for(int i=0;i<recommendTwo.length;i++)
      widgets.add(_buildRecommentTwo(recommendTwo[i], i));
    return widgets;
  }

  bool getRecommend = false;
  getRecommendTwo(){
    if(getRecommend) return;

    getRecommend = true;
    Map<String, String> map = {"position":"2"};
    new Future(() =>fetchRecommendThreeList(map)).then((recommends){
      setState(() {
        recommendTwo = recommends;
      });
    });
  }

  List<Recommend> recommendTwo = [];
  Widget _buildRecommentTwo(Recommend recommend, int index){
    return Column(children: <Widget>[
      Flexible(child: Row(children: _buildRecommendItems(recommend, index),),),
      Container(height: 1.0,width: 1000.0, color: Color(0xff000000),)
    ],);
  }

  List<Widget> _buildRecommendItems(Recommend recommend, int index){
    List<Widget> widgets = [];
    widgets.add(
        Flexible(child: Padding(padding: EdgeInsets.all(10.0),
      child: _buildRecommentTwoContent(recommend),)));
    if((index+1) % 2 == 1){
      widgets.add(Container(height: 200.0,width: 1.0, color: Color(colorDayDevider),));
    }
    return widgets;
  }

  Widget _buildRecommentTwoContent(Recommend recommend){
    return new Row(children:<Widget>[
      Expanded(
        child: new Column(children: <Widget>[
          Text(recommend.className, style: TextStyle(fontSize: 15), textAlign: TextAlign.start,),
          Text(recommend.desc, style: TextStyle(fontSize: 11),textAlign: TextAlign.start, maxLines: 1, overflow: TextOverflow.ellipsis,),
        ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,),
      ),
      new Stack(children: <Widget>[
        Image(image: NetworkImage(getPhotoUrl(recommend.cover, 100),), width: 55, height: 55, fit: BoxFit.cover,),
        Image(image: NetworkImage(getPhotoUrl(recommend.cover, 100),), height: 15, fit: BoxFit.contain,),
      ],
        alignment: AlignmentDirectional.topEnd,
      ),
    ], crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildRecommentTwo2(Recommend recommend){
    return new Container(
//      height: 50,
      child: new Stack(children: <Widget>[
        new Column(children: <Widget>[
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(getPhotoUrl(recommend.cover, 100),),),
          Text(recommend.className, style: TextStyle(fontSize: 13, color: Color(0xff333333)),)
        ],)
      ],),);
  }
}
