import 'dart:math';

import 'package:flutter/material.dart';

class DrawFingerLine extends StatelessWidget {
  const DrawFingerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: "玩哈哈"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("花花世界"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: const Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() {
    return _TestState();
  }
}

class _TestState extends State<Test>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late Animation<double> animation;
  late AnimationController controller;

  List<Offset> points = <Offset>[];
  int indexOfPointToMove = -1;
  bool drawing = true;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    // controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    debugPrint("post rebuild!");

    return Stack(
      children: [
        Listener(
          onPointerUp: (event) {
            if (drawing) {
              points.add(event.localPosition);

              setState(() {});
            }
          },
          onPointerMove: (event) {
            if (!drawing && indexOfPointToMove != -1) {
              points[indexOfPointToMove] = event.localPosition;
              setState(() {});
            }
          },
          onPointerDown: (event) {
            if (!drawing) {
              indexOfPointToMove = checkPointToMove(event.localPosition);

              setState(() {});
            }
          },
          behavior: HitTestBehavior.opaque,
          child: CustomPaint(
            key: UniqueKey(),
            foregroundPainter: TestPaint(points),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFFF5F5F5),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (points.isNotEmpty) {
              points.removeLast();
              setState(() {});
            }
          },
          child: const Icon(
            Icons.backspace,
            color: Colors.blue,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                drawing = !drawing;
              });
            },
            child: drawing
                ? const Icon(
              Icons.edit,
              color: Colors.cyan,
            )
                : const Icon(
              Icons.done,
              color: Colors.cyan,
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  int checkPointToMove(Offset pressedPoint) {
    if (points.isEmpty) {
      return -1;
    }

    var pointsToCheck = <Offset>[];
    const maxDistance = 10.0;
    for (Offset p in points) {
      if ((p.dx - pressedPoint.dx).abs() < maxDistance &&
          (p.dy - pressedPoint.dy).abs() < maxDistance) {
        pointsToCheck.add(p);
      }
    }

    if (pointsToCheck.isEmpty) {
      return -1;
    } else if (pointsToCheck.length == 1) {
      return points.indexOf(pointsToCheck[0]);
    } else {
      Offset point = pointsToCheck.first;
      var distance = distanceBetween(pointsToCheck.first, pressedPoint);
      for (int i = 1; i < pointsToCheck.length; i++) {
        var newDistance = distanceBetween(pointsToCheck[i], pressedPoint);

        if (newDistance < distance) {
          point = pointsToCheck[i];
          distance = newDistance;
        }
      }

      return points.indexOf(point);
    }
  }

  double distanceBetween(Offset first, Offset second) {
    double width = (first.dx - second.dx).abs();
    double height = (first.dy - second.dy).abs();

    return sqrt(width * width + height * height);
  }
}

class TestPaint extends CustomPainter {
  final List<Offset> points;

  TestPaint(this.points, {Key? key});

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("$size");

    canvas.drawColor(const Color(0xFFF1F1F1), BlendMode.color);
    var paint = Paint()
      ..color = const Color(0xFFE53020)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    for (var point in points) {
      canvas.drawCircle(point, 2.0, paint);
    }
    paint.color = const Color(0xFF2480F0);
    drawCurves(canvas, paint, points);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawCurves(Canvas canvas, Paint paint, List<Offset> points) {
    if (points.length <= 1) {
      return;
    }

    if (points.length == 2) {
      canvas.drawLine(points[0], points[1], paint);
      return;
    }

    if (points.length == 3) {
      _drawTwoOrderBezierCurves(canvas, paint, points);
      return;
    }

    if (points.length == 4) {
      _drawThreeOrderBezierCurves(canvas, paint, points);
      return;
    }

    var subPoints = points.sublist(0, 4);
    drawCurves(canvas, paint, subPoints);
    drawCurves(canvas, paint, points.sublist(3));
  }

  void _drawThreeOrderBezierCurves(
      Canvas canvas, Paint paint, List<Offset> points) {
    assert(points.length == 4);
    var yGap = 60.0, path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (var t = 1; t <= 100; t++) {
      var curvePoint = get3OrderBezierPoint(
          points[0], points[1], points[2], points[3], t / 100.0);
      path.lineTo(curvePoint.dx, curvePoint.dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawTwoOrderBezierCurves(
      Canvas canvas, Paint paint, List<Offset> points) {
    assert(points.length == 3);
    var path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (var t = 1; t <= 100; t++) {
      var curvePoint =
      get2OrderBezierPoint(points[0], points[1], points[2], t / 100.0);
      path.lineTo(curvePoint.dx, curvePoint.dy);
    }

    canvas.drawPath(path, paint);
  }

  Offset get3OrderBezierPoint(
      Offset p1, Offset p2, Offset p3, Offset p4, double t) {
    var x = (1 - t) * (1 - t) * (1 - t) * p1.dx +
        3 * t * (1 - t) * (1 - t) * p2.dx +
        3 * t * t * (1 - t) * p3.dx +
        t * t * t * p4.dx;
    var y = (1 - t) * (1 - t) * (1 - t) * p1.dy +
        3 * t * (1 - t) * (1 - t) * p2.dy +
        3 * t * t * (1 - t) * p3.dy +
        t * t * t * p4.dy;

    return Offset(x, y);
  }

  Offset get2OrderBezierPoint(Offset p1, Offset p2, Offset p3, double t) {
    var x = (1 - t) * (1 - t) * p1.dx + 2 * t * (1 - t) * p2.dx + t * t * p3.dx;
    var y = (1 - t) * (1 - t) * p1.dy + 2 * t * (1 - t) * p2.dy + t * t * p3.dy;

    return Offset(x, y);
  }
}
