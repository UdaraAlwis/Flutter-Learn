import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: const Text('Ask me anything!'),
          backgroundColor: Colors.blue,
        ),
        body: const Magic8BallPage(),
      ),
    ),
  );
}

class Magic8BallPage extends StatefulWidget {
  const Magic8BallPage({super.key});

  @override
  State<Magic8BallPage> createState() => _Magic8BallPageState();
}

class _Magic8BallPageState extends State<Magic8BallPage> {
  int magicValue = 1;

  void pickMagicValue() {
    setState(() {
      magicValue = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextButton(
                child: Image.asset('images/ball$magicValue.png'),
                onPressed: () {
                  pickMagicValue();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
