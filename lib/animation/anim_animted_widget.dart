import 'package:flutter/material.dart';

class AnimAnimatedWidget extends StatefulWidget {
  @override
  State<AnimAnimatedWidget> createState() => _AnimAnimatedWidgetState();
}

class _AnimAnimatedWidgetState extends State<AnimAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<EdgeInsets> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    _animation = _controller.drive(EdgeInsetsTween(
        begin: EdgeInsets.fromLTRB(50, 50, 0, 0),
        end: EdgeInsets.only(top: 200, left: 200)));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      _controller.forward();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimAnimatedWidget"),
          ),
          body: EdgeInsetsDemo(
            animation: _animation,
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 使用AnimatedWidget分离
class EdgeInsetsDemo extends AnimatedWidget {
  EdgeInsetsDemo({Key? key, required Animation<EdgeInsets> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<EdgeInsets> animation = listenable as Animation<EdgeInsets>;
    return Container(
      margin: animation.value,
      width: 100,
      height: 100,
      color: Colors.redAccent,
    );
  }
}
