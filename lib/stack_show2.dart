
import 'package:flutter/material.dart';

class StackShowRelativeLayout2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new StackShow2(),
      );
  }
}

class StackShow2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(title: new Text("Stack Show 1"),elevation: 0.0,),
        body: new Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: Text("Center"),),
            Align(alignment: Alignment.topRight, child: Text("Top\nRight"),),
            Align(alignment: Alignment.centerRight, child: Text("Center\nRight"),),
            Align(alignment: Alignment.bottomRight, child: Text("Bottom\nRight"),),
            Align(alignment: Alignment.topLeft, child: Text("Top\nLeft"),),
            Align(alignment: Alignment.centerLeft, child: Text("Center\nLeft"),),
            Align(alignment: Alignment.bottomLeft, child: Text("Bottom\nLeft"),),
            Align(alignment: Alignment.topCenter, child: Text("Top\nCenter"),),
            Align(alignment: Alignment.bottomCenter, child: Text("Bottom\nCenter"),),
            Align(alignment: Alignment(0.0, 0.5), child: Text("Custom\nPostition", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.w800),),),
          ],
      ),
    );
  }

}