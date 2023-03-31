import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Clock extends StateNotifier<DateTime> {
  late final Timer _timer;

  Clock() : super(DateTime.now()) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

var clockProvider = StateNotifierProvider<Clock, DateTime>(
  (ref) {
    return Clock();
  },
);

class ClockWidget extends ConsumerWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var time = ref.watch(clockProvider);

    var formattedTime = DateFormat.Hms().format(time);

    return Text(
      formattedTime,
      style: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
          fontSize: 80),
    );
  }
}
