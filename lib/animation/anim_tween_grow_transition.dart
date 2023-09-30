import 'package:flutter/material.dart';

// #docregion LogoWidget
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
// #enddocregion LogoWidget

// #docregion GrowTransition
class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
// #enddocregion GrowTransition

class AnimTween extends StatefulWidget {
  const AnimTween({super.key});

  @override
  State<AnimTween> createState() => _AnimTweenState();
}

// #docregion print-state
class _AnimTweenState extends State<AnimTween>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  // #enddocregion print-state

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Tween Anim Listener"),
        ),
        body: GrowTransition(
          animation: animation,
          child: const FlutterLogo(),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
// #docregion print-state
}
