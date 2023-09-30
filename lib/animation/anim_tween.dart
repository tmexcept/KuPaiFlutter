import 'package:flutter/material.dart';

class AnimTween extends StatefulWidget {

  @override
  State<AnimTween> createState() => _AnimTweenState();
}

class _AnimTweenState extends State<AnimTween> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Tween Anim"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}