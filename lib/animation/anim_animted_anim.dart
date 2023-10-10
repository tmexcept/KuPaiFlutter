import 'package:flutter/material.dart';

class AnimAnimatedAnim extends StatefulWidget {
  @override
  State<AnimAnimatedAnim> createState() => _AnimAnimatedAnimState();
}

class _AnimAnimatedAnimState extends State<AnimAnimatedAnim>
    with SingleTickerProviderStateMixin {
  late Duration _duration = Duration(seconds: 1);
  late bool _animation = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter动画 AnimAnimatedAnims"),
          ),
          body: getContent()),
    );
  }

  Center getContent() {
    return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        AnimatedContainer(
          curve: Curves.linear,
          duration: _duration,
          width: _animation ? 200 : 100,
          height: _animation ? 200 : 100,
          decoration: BoxDecoration(
              borderRadius:
                  _animation ? BorderRadius.circular(100) : BorderRadius.zero,
              color: _animation ? Colors.yellowAccent : Colors.redAccent,
              border: Border.all(
                  width: 5,
                  color: _animation ? Colors.greenAccent : Colors.black87)),
          onEnd: () {
            // 动画结束的回调
            setState(() => _animation = !_animation);
          },
          child: InkWell(
            onTap: () {
              setState(() => _animation = !_animation);
            },
          ),
        ),
        Spacer(),
        AnimatedContainer(
          alignment: Alignment.center,
          duration: _duration,
          width: _animation ? 200 : 150,
          height: _animation ? 100 : 80,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: _animation == false
                ? BorderRadius.circular(40)
                : BorderRadius.zero,
          ),
          child: AnimatedDefaultTextStyle(
            duration: _duration,
            child: Text("Hello world"),
            style: _animation
                ? TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w100)
                : TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
          ),
        ),
        Spacer(),
        // AnimatedCrossFade 2个组件在切换时出现交叉渐入的效果，需要设置动画前、动画后2个子控件即可。
        AnimatedCrossFade(
          duration: _duration,
          crossFadeState: _animation
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Container(
            alignment: Alignment.center,
            width: 100,
            height: 120,
            color: Colors.redAccent,
            child: Text(
              "第一个",
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
          secondChild: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(50)),
            child: Text("第二个", style: TextStyle(color: Colors.redAccent)),
          ),
        ),
        Spacer(
          flex: 2,
        )
      ],
    ),
  );
  }
}
