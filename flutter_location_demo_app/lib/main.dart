import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'location_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Location Demo App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: ref.watch(locationNotifierProvider).when(
                    data: (data) => Text(
                          'Location: Lat - ${data?.latitude}, Long - ${data?.longitude}',
                          style: const TextStyle(fontSize: 20),
                        ),
                    error: (error, stack) => Text(
                          error.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                    loading: () => const Center(
                        child: CircularProgressIndicator.adaptive())),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                    onPressed: () async {
                      await ref
                          .watch(locationNotifierProvider.notifier)
                          .getCurrentLocation();
                    },
                    child: Text(
                      ref.watch(locationNotifierProvider).isLoading
                          ? 'Please Wait...'
                          : 'Update Location',
                      style: const TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
