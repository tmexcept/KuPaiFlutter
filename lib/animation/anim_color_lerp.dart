import 'package:flutter/material.dart';

class AnimColorLerp extends StatefulWidget {
  @override
  State<AnimColorLerp> createState() => _AnimColorLerpState();
}

class _AnimColorLerpState extends State<AnimColorLerp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Color _color = Colors.red;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          _color = Color.lerp(Colors.red, Colors.green, _controller.value)!;
        });
      })..addStatusListener((status) {
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
            title: Text("Flutter动画 AnimColorLerp"),
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
      color: _color,
      child: Center(child: Text("AnimColorLerp"),),
    ),
  );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
