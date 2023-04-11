import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var counterNotifierProvider = ChangeNotifierProvider((ref) {
  return Counter();
});

class Counter extends ChangeNotifier {
  int _count = 0;
  get count => _count;

  void increase() {
    _count++;
    notifyListeners();
  }
}

class CounterChangeNotifierWidget extends ConsumerWidget {
  const CounterChangeNotifierWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var count = ref.watch(counterNotifierProvider).count;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(counterNotifierProvider).increase();
          },
          child: Text(
            'Clicked Me $count times!',
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
