
import 'package:flutter/material.dart';

class StackShowRelativeLayout1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new StackShow1(),);
  }

}

class StackShow1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return new Scaffold(
      appBar: new AppBar(title: new Text("Stack Show 1"),elevation: 0.0,),
      body: new Stack(
        children: <Widget>[
          Positioned(left: 0.0, child: Text("Top\nleft")),
          Positioned(bottom: 0.0, child: Text("Bottom\nleft")),
          Positioned(top: 0.0, right: 0.0, child: Text("Top\nright")),
          Positioned(bottom: 0.0, right: 0.0, child: Text("Bottom\nright")),
          Positioned(bottom: 0.0, right: 0.0, child: Text("Bottom\nright")),
          Positioned(left: width / 2, top: height / 2, child: Text("Center")),
          Positioned(top: height / 2, child: Text("Center\nleft")),
          Positioned(top: height / 2, right: 0.0, child: Text("Center\nright")),
          Positioned(left: width / 2, child: Text("Center\ntop")),
          Positioned(left: width / 2, bottom: 0.0, child: Text("Center\nbottom")),
        ],
      ),
    );
  }

}