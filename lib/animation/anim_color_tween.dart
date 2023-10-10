import 'package:flutter/material.dart';

class AnimColorTween extends StatefulWidget {
  @override
  State<AnimColorTween> createState() => _AnimColorTweenState();
}

class _AnimColorTweenState extends State<AnimColorTween> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1))
      ..addListener(() {
        setState(() { });
      });
    _animation = ColorTween(begin: Colors.red,end: Colors.green).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimColorTween"),
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
      height: 100,width: 100,
      color: _animation.value,
    ),
  );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
