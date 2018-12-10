import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapp/httprequest.dart';

class AuctionFeedList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new AuctionFeedListState();
}

class AuctionFeedListState extends State<AuctionFeedList> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //...
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.pin,
              title: Text("haha", maxLines: 1,),
              background: FadeInImage.assetNetwork(
                placeholder: 'lib/image/icon_splash.jpg',
                image: "https://avatar-static.segmentfault.com/206/120/2061206110-5afe2c9d40fa3_big64",
                fit: BoxFit.fitWidth,
                width: 1000.0, height: 800.0,),
            ),
          ),
          SliverToBoxAdapter(child: boxAdapterWidget(context))
        ],
      )
    );
  }

  Widget boxAdapterWidget(context) {
    return FutureBuilder<String>(
      future: fetchDetail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                        text: snapshot.data,
                        style: DefaultTextStyle.of(context).style),
                  )));
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
