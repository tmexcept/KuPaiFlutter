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
                new Container(
                  height: 250.0,
                  padding: const EdgeInsets.only(top: 200.0),
                  decoration: new BoxDecoration(image: new DecorationImage(image: new NetworkImage(getAuctionFeedCover(data.bidGoods.pic)))),
                  child: new Row(children: <Widget>[
                    new Icon(
                      Icons.chat,
                      color: Colors.lightBlueAccent,
                    ),
                    new Expanded(
                      child: new Text(
                        "消息记录",
                        textAlign: TextAlign.right,
                      ),
                    )
                  ]),
                )
              ],
            ),
        )
    );
  }


  Widget supplierTags(Supplier supplier, BuildContext context){
//    debugPrint("${supplier.tags}  ${supplier.tags.length}");
    List<Chip> tags = [];
    for(int i=0;i<supplier.tags.length;i++){
      tags.add(Chip(
        label: Text(supplier.tags[i], style: TextStyle(fontSize: 11.0),),
        shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xffc4311d)), borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20))),
        backgroundColor: Colors.white,
        labelPadding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 0.0),
//        padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
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
