//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterapp/httprequest_error.dart';
//
//
// class AuctionFeedListError extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => new AuctionFeedListState();
// }
//
// class AuctionFeedListState extends State<AuctionFeedListError> {
//
//   @override
//   Widget build(BuildContext context) {
//     print("========================");
//     return new Scaffold(
//       appBar: new AppBar(title: Text("Feed Data error"),),
//       //...
//       body: boxAdapterWidget(context),
//     );
//   }
//
//   Widget boxAdapterWidget(context) {
//     return FutureBuilder<String>(
//       future: fetchDetailEntity(context),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Center(
//               child: Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: RichText(
//                     text: TextSpan(
//                         text: snapshot.data,
//                         style: DefaultTextStyle.of(context).style),
//                   )));
// //          return ListView.builder(
// //              itemCount: snapshot.data.length,
// //              itemBuilder: (context, index) =>
// //                  listItem(context, index, snapshot.data[index]));
//         } else if (snapshot.hasError) {
//           return Center(child: Text('${snapshot.error}'));
//         }
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
