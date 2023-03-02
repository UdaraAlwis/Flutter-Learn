import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Center(
          child: TextButton(
              onPressed: () {
                // final audioCache = AudioCache();
                // audioCache.load('note1.wav');
                player.pause();
                player.play(AssetSource('note1.wav'));
              },
              child: const Text('Click me')),
        )),
      ),
    );
  }
}
