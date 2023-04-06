import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

var datetimeStreamProvider = StreamProvider.autoDispose<DateTime>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (count) => DateTime.now());
});

// final datetimeProvider = Provider((ref) {
//   late DateTime _value;
//   late final Timer _timer;
//   _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
//     _value = DateTime.now();
//   });
//   return _value;
// });

class ClockStreamWidget extends ConsumerWidget {
  const ClockStreamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTimeAsync = ref.watch(datetimeStreamProvider);

    return dateTimeAsync.when(data: (data) {
      var formattedTime = DateFormat.Hms().format(data);
      return Text(
        formattedTime,
        style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.normal,
            fontSize: 80),
      );
    }, error: (error, stack) {
      return Text('Error $error');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
