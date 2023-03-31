import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var counter = ref.watch(counterStateProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(counterStateProvider.notifier).state++;
          },
          child: Text(
            'Value: $counter',
            style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
                fontSize: 80),
          ),
        ),
      ),
    );
  }
}
