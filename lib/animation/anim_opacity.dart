import 'package:flutter/material.dart';

const owlUrl =
    'https://raw.githubusercontent.com/flutter/website/main/src/assets/images/docs/owl.jpg';

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  State<FadeInDemo> createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network(
        owlUrl,
        width: 200,
      ),
      TextButton(
        child: const Text(
          'Show Details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => setState(() {
          opacity = 1;
        }),
      ),
      AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: opacity,
        child: const Column(
          children: [
            Text('Type: Owl', style: TextStyle(fontSize: 24)),
            Text(
              'Age: 39',
              style: TextStyle(backgroundColor: Colors.grey),
            ),
            Text('Employment: None'),
          ],
        ),
      ),
      Text(
        'Employment: None',
        style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
      ),
      OutlinedButton(
        child: Text('Employment: None'),
        onPressed: () => {},
      ),
    ]);
  }
}

class AnimOpacity extends StatelessWidget {
  const AnimOpacity({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FadeInDemo(),
    );
  }
}
