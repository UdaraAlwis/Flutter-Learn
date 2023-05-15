import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {'*': (context, state, data) => const ScaffoldWithBottomNavBar()},
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  var routerDelegate = [
    BeamerDelegate(
        initialPath: '/a',
        locationBuilder: (routerInformation, _) {
          if (routerInformation.location!.contains('/a')) {
            return (ALocation(routerInformation));
          } else {
            return NotFound(path: routerInformation.location!);
          }
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
