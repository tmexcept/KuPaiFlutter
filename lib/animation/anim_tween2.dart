import 'package:flutter/material.dart';

class AnimTween extends StatefulWidget {
  @override
  State<AnimTween> createState() => _AnimTweenState();
}

class _AnimTweenState extends State<AnimTween> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    // AnimationController继承于Animation，可以调用addListener
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    // Interval : begin 参数 代表 延迟多长时间开始 动画  end 参数 代表 超过多少 直接就是 100% 即直接到动画终点
    _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.linear)));
    // _animation有不同的构建方式
    // _animation = Tween(begin: 1.0,end: 0.2).chain(CurveTween(curve: Curves.easeIn)).animate(_controller);
    //  _animation = _controller.drive(Tween(begin: 1.0,end: 0.1)).drive(CurveTween(curve: Curves.linearToEaseOut));
  }

  @override
  Widget build(BuildContext context) {
    // 动画期间会不停调用build方法
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimTween"),
          ),
          body: getContent()),
    );
  }

  InkWell getContent() {
    return InkWell(
    onTap: () => _controller.forward(),
    child: Opacity(
      opacity: _animation.value,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.greenAccent,
        child: Center(
          child: Text("anim_tween2"),
        ),
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
