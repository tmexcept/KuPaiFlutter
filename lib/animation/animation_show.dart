import 'package:flutter/material.dart';
import 'package:flutterapp/animation/anim_container.dart';

import '/animation/anim_tween.dart';
import '/animation/anim_tween_animation.dart' as animTween2;
import '/animation/anim_tween_animation_listener.dart' as animTween3;
import '/animation/anim_tween_grow_transition.dart' as animTween4;
import '/animation/anim_tween_curve.dart' as animTween5;
import 'anim_bounce_ball.dart';
import 'anim_opacity.dart';

class AnimShow extends StatefulWidget {
  @override
  State<AnimShow> createState() => _AnimShowState();
}

class _AnimShowState extends State<AnimShow> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Animation 页面"),
      ),
      body: SingleChildScrollView(
        child: buildCenter(context),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildCenter(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnimTween())),
          icon: Icon(Icons.animation),
          label: Text("tween 动画"),
        ),
        ColoredBox(color: Colors.deepPurple, child: Padding(padding: EdgeInsets.fromLTRB(0,10, 0, 0),),),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => animTween2.AnimTween())),
          icon: Icon(Icons.animation),
          label: Text("tween animation"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => animTween3.AnimTween())),
          icon: Icon(Icons.animation),
          label: Text("tween animation addListener"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => animTween4.AnimTween())),
          icon: Icon(Icons.animation),
          label: Text("tween animation grow transition"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => animTween5.AnimTween())),
          icon: Icon(Icons.animation),
          label: Text("tween animation curve"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimBounceBall())),
          icon: Icon(Icons.animation),
          label: Text("anim bounce ball"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimContainer())),
          icon: Icon(Icons.animation),
          label: Text("anim container"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimOpacity())),
          icon: Icon(Icons.animation),
          label: Text("anim Opacity"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }
}
