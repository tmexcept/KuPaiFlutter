import 'package:flutter/material.dart';

class AnimSizeChange2 extends StatefulWidget {
  @override
  State<AnimSizeChange2> createState() => _AnimSizeChange2State();
}

class _AnimSizeChange2State extends State<AnimSizeChange2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation <double> _sizeAnimation;
  late Animation <BorderRadius?> _radiusAnimation;
  late Animation <Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1))..addListener(() {
      setState(() {});
    })..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _sizeAnimation = Tween(begin: 100.0,end: 200.0).chain(CurveTween(curve: Curves.linear)).animate(_controller);
    _radiusAnimation = BorderRadiusTween(begin: BorderRadius.zero,end: BorderRadius.circular(100)).animate(_controller);
    _colorAnimation = ColorTween(begin: Colors.redAccent,end: Colors.yellowAccent).chain(CurveTween(curve: Curves.linear)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimSizeChange2"),
          ),
          body: getContent()),
    );
  }

  InkWell getContent() {
    return InkWell(
            onTap: (){
              _controller.forward();
            },
            child: Container(
              width: _sizeAnimation.value,height: _sizeAnimation.value,
              decoration: BoxDecoration(
                  border: Border.all(width: 5,color: Colors.greenAccent),
                  color: _colorAnimation.value,
                  borderRadius: _radiusAnimation.value
              ),
              child: Center(child: Text("AnimSizeChange2"),),
            ),
          );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
