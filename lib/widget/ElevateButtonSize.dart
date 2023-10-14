import 'package:flutter/material.dart';

class ElevateButtonSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ElevateButtonSize"),
        ),
        body: DemoWidget(),
      ),
    );
  }
}

class DemoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoWidgetState();
  }
}

class DemoWidgetState extends State<DemoWidget> {
  @override
  Widget build(BuildContext context) {
    print("执行执行MyCounterState的build方法");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 3),
          ElevatedButton(onPressed: () {}, child: const Text("默认情况下的宽高")),
          const SizedBox(height: 3),
          SizedBox(
            width: 330,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("设置固定宽高(使用SizeBox)"),
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(330, 50)),
            ),
            child: const Text("设置固定宽高(使用ButtonStyle)"),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(330, 50),
            ),
            child: const Text("设置固定宽高(使用ElevatedButton.styleFrom)"),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 330,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("只设置宽度,高度默认(SizeBox)"),
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(330),
            ),
            child: const Text("只设置宽度,高度默认(style)"),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("只设置高度,宽度默认(SizeBox)"),
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromHeight(50),
            ),
            child: const Text("只设置高度,宽度默认(style)"),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("宽度占满，高度默认(SizeBox)"),
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(10000),
            ),
            child: const Text("宽度占满，高度默认(style)"),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text("去掉Button边距"),
          ),
        ],
      ),
    );
  }
}
