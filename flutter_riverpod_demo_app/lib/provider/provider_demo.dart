import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var helloWorldProvider = Provider<String>(
  (ref) {
    return 'Hello World!';
  },
);

// Using Provider with Consumer Widget

class HelloWorldWidget1 extends StatelessWidget {
  const HelloWorldWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        var helloWorld = ref.watch(helloWorldProvider);
        return Text(
          helloWorld,
          style: const TextStyle(
              color: Colors.lightBlueAccent,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.normal,
              fontSize: 80),
        );
      },
    );
  }
}

// Using Provider with ConsumerWidget

class HelloWorldWidget2 extends ConsumerWidget {
  const HelloWorldWidget2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var helloWorld = ref.watch(helloWorldProvider);

    return Text(
      helloWorld,
      style: TextStyle(
          color: Colors.purpleAccent.shade400,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
          fontSize: 80),
    );
  }
}

// Using Provider with ConsumerStatefulWidget

class HelloWorldWidget3 extends ConsumerStatefulWidget {
  const HelloWorldWidget3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HelloWorldWidget3State();
}

class _HelloWorldWidget3State extends ConsumerState<HelloWorldWidget3> {
  @override
  void initState() {
    super.initState();

    final helloWorld = ref.read(helloWorldProvider);
    print(helloWorld);
  }

  @override
  Widget build(BuildContext context) {
    var helloWorld = ref.watch(helloWorldProvider);
    return Text(
      helloWorld,
      style: TextStyle(
          color: Colors.redAccent.shade400,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
          fontSize: 80),
    );
  }
}
