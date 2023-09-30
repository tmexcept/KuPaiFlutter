import 'package:flutter/material.dart';

class WidgetLifeCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Widget LifeCircle"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("HomeBody build");
    return MyCounterWidget();
  }
}

class MyCounterWidget extends StatefulWidget {
  MyCounterWidget() {
    print("执行了MyCounterWidget的构造方法");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了MyCounterWidget的createState方法");
    // 将创建的State返回
    return MyCounterState();
  }
}

class MyCounterState extends State<MyCounterWidget> {
  int counter = 0;

  MyCounterState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    print("执行MyCounterState的init方法");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("执行MyCounterState的didChangeDependencies方法");
  }

  @override
  Widget build(BuildContext context) {
    print("执行执行MyCounterState的build方法");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  "+1",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
              ),
              MaterialButton(
                color: Colors.orangeAccent,
                child: Text(
                  "-1",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    counter--;
                  });
                },
              )
            ],
          ),
          Text(
            "当前计数：$counter",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(MyCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}
