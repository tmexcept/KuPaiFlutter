import 'package:flutter/material.dart';

class AnimAnimatedBuild extends StatefulWidget {
  @override
  State<AnimAnimatedBuild> createState() => _AnimAnimatedBuildState();
}

class _AnimAnimatedBuildState extends State<AnimAnimatedBuild>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Matrix4> _animation;

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
          })
          ..addListener(() {
            setState(() {});
          });
    _animation = Matrix4Tween(
            begin: Matrix4.identity()..rotateX(0.0),
            end: Matrix4.identity()..rotateX(3))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    print("AnimAnimatedBuild build");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimAnimatedBuild"),
          ),
          body: Center(
            child: InkWell(
                onTap: () {
                  _controller.forward();
                },
                child: AnimatedBuilderDemo(
                  animation: _animation,
                )),
          )
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 使用AnimatedBuilder重构
class AnimatedBuilderDemo extends AnimatedWidget {
  AnimatedBuilderDemo({Key? key, required Animation<Matrix4> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    print("AnimAnimatedBuild AnimatedBuilderDemo build");
    final Animation animation = listenable as Animation;
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset(
        "lib/kupai/image/icon_splash.jpg",
      ),
      builder: (context, child) {
        return Container(
          height: 200,//如果不配置width，则宽度自动适配图片宽度
          transform: animation.value,
          child: child,
        );
      },
    );
  }
}
