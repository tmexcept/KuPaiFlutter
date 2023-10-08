import 'package:flutter/material.dart';

class CounterInheritedWidget extends InheritedWidget {
  /// 构造方法
  const CounterInheritedWidget({Key? key, required this.count,
    required Widget child}):super(key:key, child: child);

  /// 需要共享的数据
  final int count;

  /// 默认的约定：如果状态是希望暴露出的，应当提供一个`of`静态方法来获取其对象，开发者便可直接通过该方法来获取
  /// 返回实例对象，方便子树中的widget获取共享数据
  static CounterInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  /// 是否通知widget树中依赖该共享数据的子widget
  /// 这里当count发生变化时，是否通知子树中所有依赖count的Widget重新build
  /// 这里判断注意：是值改变还是内存地址改变。
  @override
  bool updateShouldNotify(covariant CounterInheritedWidget oldWidget) {
    return count != oldWidget.count;
  }
}
class CounterOneWidget extends StatelessWidget {
  const CounterOneWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("CountInheritedWidget CounterOneWidget StatelessWidget  build");
    return Container(
      width: 100, height: 100,
      color: Colors.redAccent,
      alignment: Alignment.center,
      child: Text(CounterInheritedWidget.of(context)!.count.toString(),style: const TextStyle(fontSize: 20),),
    );
  }
}
class CounterTwoWidget extends StatefulWidget {
  const CounterTwoWidget({Key? key}) : super(key: key);
  @override
  State<CounterTwoWidget> createState() => _CounterTwoWidgetState();
}

class _CounterTwoWidgetState extends State<CounterTwoWidget> {
  @override
  Widget build(BuildContext context) {
    print("CountInheritedWidget _CounterTwoWidgetState StatefulWidget build");
    return Container(
      width: 100, height: 100,
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: Text(CounterInheritedWidget.of(context)!.count.toString(),style: const TextStyle(fontSize: 20),),
    );
  }
}

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);
  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    print("CountInheritedWidget _countPageState build");
    return Scaffold(
      appBar: AppBar(title: const Text("InheritedWidget"),),
      body: CounterInheritedWidget( /// 父节点使用
        count: _count,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [ /// 所有子节点均可以共享数据
              CounterOneWidget(),
              CounterTwoWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("CountInheritedWidget floatingActionButton onPressed mounted=$mounted");
          if(!mounted) return;
          setState(() {
            _count += 1;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

