import 'package:flutter/material.dart';

class AnimSizeChange extends StatefulWidget {
  @override
  State<AnimSizeChange> createState() => _AnimSizeChangeState();
}

class _AnimSizeChangeState extends State<AnimSizeChange>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _size = 100; //必须初始化，否则崩溃

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 100,
        upperBound: 200)
      ..addListener(() {
        setState(() {
          _size = _controller.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimSizeChange"),
          ),
          body: getContent()),
    );
  }

  Widget getContent(){
    return InkWell(
      onTap: () {
        _controller.forward();
      },
      child: Container(
        width: _size,
        height: _size,
        color: Colors.redAccent,
        child: Center(
          child: Text("Demo3"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
