import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '1_provider/provider_demo.dart';
import '2_state_provider/state_provider_demo.dart';
import '3_state_notifier_provider/state_notifier_provider.dart';
import '4_future_provider/future_provider.dart';
import '5_stream_provider/stream_provider.dart';
import '6_change_noifier_provider/change_notifier_provider.dart';

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
          CounterStateProviderWidget(),
          ClockStateNotifierWidget(),
          WeatherFutreProvderWidget(),
          ClockStreamWidget(),
          CounterChangeNotifierWidget(),
        ],
      ),
    );
  }
}
