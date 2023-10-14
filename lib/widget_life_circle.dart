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
/// mounted 是 State 对象中的一个属性，此属性表示当前组件是否在树中（在创建 State 之后，调用 initState 之前，
/// Framework 会将 State 和 BuildContext 进行关联），当 Framework 调用 dispose 时，mounted 被设置为 false，表示当前组件已经不在树中。
// createState 函数执行完毕后表示当前组件已经在组件树中，属性 mounted 被 Framework 设置为 true，
// 平时写代码时或者看其他开源代码时经常看到如下代码：
// scss复制代码if(mounted){
//     setState(() { ... });
// }
//
// 强烈建议：在调用 setState 时加上 mounted 判断。
// 为什么要加上如此判断？因为如果当前组件未插入到树中或者已经从树中移除时，
// 调用 setState 会抛出异常，加上 mounted 判断，则表示当前组件在树中。
//
// dirty 和 clean
// dirty 表示组件当前的状态为 脏状态，下一帧时将会执行 build 函数，调用 setState 方法或者 执行 didUpdateWidget 方法后，组件的状态为 dirty。
// clean 与 dirty 相对应，clean 表示组件当前的状态为干净状态，clean 状态下组件不会执行 build 函数。
class MyCounterState extends State<MyCounterWidget> with WidgetsBindingObserver {
  int counter = 0;
  late MaterialButton butt;

  MyCounterState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    print("执行MyCounterState的initState方法");
    WidgetsBinding.instance.addObserver(this);
    /// 页面渲染完毕回调 addPostFrameCallback 是 StatefulWidge 渲染结束的回调，只会被调用一次，之后 StatefulWidget刷新 UI 也不会被调用。
    /// 在initState不能调用BuildContext.dependOnInheritedWidgetOfExactType，可以使用addPostFrameCallback规避此限制
    WidgetsBinding.instance.addPostFrameCallback((_) => {});
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
              butt = MaterialButton(
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
                  print("butt= $butt,  butt.key=${butt.key}");
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("didChangeAppLifecycleState state=$state");
    if (state == AppLifecycleState.resumed) {

    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}
