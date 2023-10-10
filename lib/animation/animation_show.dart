import 'package:flutter/material.dart';
import 'package:flutterapp/animation/anim_animted_build.dart';
import 'package:flutterapp/animation/anim_container.dart';
import 'package:flutterapp/animation/anim_size_change2.dart';

import '/animation/anim_tween.dart';
import '/animation/anim_tween_animation.dart' as animTween2;
import '/animation/anim_tween_animation_listener.dart' as animTween3;
import '/animation/anim_tween_grow_transition.dart' as animTween4;
import '/animation/anim_tween_curve.dart' as animTween5;
import '/animation/anim_tween2.dart' as animTween6;
import 'anim_animted_anim.dart';
import 'anim_animted_widget.dart';
import 'anim_bounce_ball.dart';
import 'anim_color_lerp.dart';
import 'anim_color_tween.dart';
import 'anim_opacity.dart';
import 'anim_size_change.dart';

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
              MaterialPageRoute(builder: (context) => animTween6.AnimTween())),
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
        FilledButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimSizeChange())),
          child: Text("AnimSizeChange  FilledButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        FilledButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimSizeChange2())),
          child: Text("AnimSizeChange2  FilledButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimColorLerp())),
          child: Text("AnimColorLerp  ElevatedButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ElevatedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimColorTween())),
          child: Text("AnimColorLerp  ElevatedButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        OutlinedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimAnimatedWidget())),
          child: Text("AnimAnimatedWidget  OutlinedButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        OutlinedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimAnimatedBuild())),
          child: Text("AnimAnimatedBuild  OutlinedButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        MaterialButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimAnimatedAnim())),
          child: Text("AnimAnimatedAnim  MaterialButton"),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }
}
