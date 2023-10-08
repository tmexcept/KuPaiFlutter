import 'dart:math';

import 'package:flutter/material.dart';

/// 我们使用更加贴合日常开发的模型类作为需要共享的数据来类比。
class Person {
  String name;
  int age;

  Person({required this.name, required this.age});
}

class PersonInheritedWidget extends InheritedWidget {
  /// 构造方法
  const PersonInheritedWidget(
      {Key? key,
      required this.person,
      required this.updateCallback,
      required Widget child})
      : super(key: key, child: child);

  /// 需要共享的数据
  final Person person;

  /// 我们使用回调方法来更新数据
  final Function(Person person) updateCallback;

  /// 定义一个便捷方法，获取对象，方便子树中的widget获取共享数据
  /// 会注册依赖关系，当InheritedWidget 发生变化时，就会更新依赖它的子孙组件，
  /// 也就是会调这些子孙组件的 didChangeDependencies() 方法和 build() 方法
  static PersonInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PersonInheritedWidget>();
  }

  /// 没有注册依赖关系，所以之后当 InheritedWidget 发生变化时，就不会更新相应的子孙Widget。
  static PersonInheritedWidget? of2(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<PersonInheritedWidget>()!.widget as PersonInheritedWidget;
  }

  /// 提供一个刷新方法
  void updateInfo(Person person) {
    updateCallback(person);
  }

  /// 是否通知依赖该树共享数据的子widget
  @override
  bool updateShouldNotify(covariant PersonInheritedWidget oldWidget) {
    return person != oldWidget.person;
  }
}

class PersonStateWidget extends StatefulWidget {
  const PersonStateWidget({Key? key, required this.person, required this.child})
      : super(key: key);
  final Person person;
  final Widget child;

  @override
  _PersonStateWidgetState createState() => _PersonStateWidgetState();
}

class _PersonStateWidgetState extends State<PersonStateWidget> {
  late Person _person;

  @override
  void initState() {
    _person = widget.person;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("PersonInheritedWidget 开始创建 build");
    return PersonInheritedWidget(
        person: _person, updateCallback: _updateCallback, child: widget.child);
  }

  /// 使用setState更新数据
  void _updateCallback(Person person) {
    if (!mounted) return;
    setState(() {
      _person = person;
    });
  }
}

/// 由于跨页面，`InheritedWidget`需要在`MaterialApp`的上层节点
class PersonPage extends StatelessWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container();
    return PersonStateWidget(
      person: Person(name: "张三", age: 18),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const FirstPage(),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() {
    print("第一页的数据开始创建  createState");
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    print("第一页的数据 build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("FirstPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "姓名：${PersonInheritedWidget.of(context)!.person.name}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "年龄：${PersonInheritedWidget.of(context)!.person.age}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// 跳转下一页
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SecondPage();
          }));
        },
        child: const Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() {
    print("第二页的数据开始创建  createState");
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    print("第二页的数据 build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "姓名：${PersonInheritedWidget.of(context)!.person.name}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "年龄：${PersonInheritedWidget.of(context)!.person.age}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("第二页的数据点击更新");
          /// 点击更改数据
          PersonInheritedWidget.of(context)
              ?.updateCallback(Person(name: "李四", age: Random().nextInt(30)+10));
        },
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }
}
