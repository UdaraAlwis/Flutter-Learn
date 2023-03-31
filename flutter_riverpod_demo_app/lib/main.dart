import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo_app/state_provider/state_provider_demo.dart';

import 'provider/provider_demo.dart';
import 'state_notifier_provider/state_notifier_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        children: const [
          HelloWorldWidget1(),
          HelloWorldWidget2(),
          HelloWorldWidget3(),
          CounterWidget(),
          ClockWidget(),
        ],
      ),
    );
  }
}
