import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  void playSound(int keyValue) {
    var player = AudioPlayer();
    player.play(AssetSource('note$keyValue.wav'));
  }

  Expanded buildKeyButton({required int keyValue}) {
    const keyValueColorMap = {
      1: Colors.red,
      2: Colors.orange,
      3: Colors.yellow,
      4: Colors.green,
      5: Colors.teal,
      6: Colors.blue,
      7: Colors.purple,
    };

    return Expanded(
      child: MaterialButton(
        onPressed: () {
          playSound(keyValue);
        },
        color: keyValueColorMap[keyValue] ?? Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKeyButton(keyValue: 1),
              buildKeyButton(keyValue: 2),
              buildKeyButton(keyValue: 3),
              buildKeyButton(keyValue: 4),
              buildKeyButton(keyValue: 5),
              buildKeyButton(keyValue: 6),
              buildKeyButton(keyValue: 7),
            ],
          ),
        ),
      ),
    );
  }
}
