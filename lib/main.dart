import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'animation/animation_show.dart';
import 'kupai/gridview.dart';
import 'kupai/song_relativelayout.dart';
import 'stack_show1.dart';
import 'stack_show2.dart';
import 'themecolor.dart';
import 'text_style.dart';

import 'widget_life_circle.dart';

void main() => runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    ));

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      if (_counter > 10) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ThemeColor()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: buildCenter(context),
        padding: EdgeInsets.all(10.0),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment tooltip',
        child: new Icon(
          Icons.add,
          color: Colors.lightGreenAccent,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildCenter(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => WidgetLifeCircle())),
          child: new Text("Widget LifeCircle",
              style: TextStyle(color: Colors.deepOrangeAccent)),
        ),
        ElevatedButton(
          onPressed: () => _getBatteryLevel,
          child: new Text("getBatteryLevel:" + _batteryLevel,
              style: TextStyle(color: Colors.deepOrangeAccent)),
          // textColor: Colors.lightBlue,
        ),
        new Text(
          'You have pushed the button this many times:(times bigger than 10 will jump to ThemeColor Screen)',
          style: new TextStyle(color: Colors.redAccent),
        ),
        new Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
        new Text(
          '$_counter',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text("getData and show in text"),
        // ElevatedButton(
        //   onPressed: () => Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => AuctionFeedList())),
        //   child: new Text("button"),
        //   // textColor: Colors.lightBlue,
        // ),
        Text("getData and show in list"),
        // ElevatedButton.icon(
        //     onPressed: () => Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => AuctionFeedListShow())),
        //     icon: new Icon(Icons.android),
        //     label: Text("显示Feed流")),
        ElevatedButton.icon(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShopPageFragment())),
            icon: new Icon(Icons.android),
            label: Text("GridView")),
        TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SongRelativeLayout())),
          child: Text("TextButton 显示tab"),
        ),
        OutlinedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StackShowRelativeLayout1())),
          child: Text("OutlinedButton 显示Stack中的Positioned"),
        ),
        FilledButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StackShowRelativeLayout2())),
          child: Text("FilledButton 显示Stack中的Align"),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnimShow())),
          icon: Icon(Icons.animation),
          label: Text("跳转动画页面"),
        ),
        Padding(padding: EdgeInsets.only(top: 10),),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TextDemo())),
          icon: Icon(Icons.animation),
          label: Text("Text Demo"),
        ),
      ],
    );
  }

  String _batteryLevel = 'Unknown battery level.';

  static const platform = const MethodChannel('flutter.io/sign');

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
