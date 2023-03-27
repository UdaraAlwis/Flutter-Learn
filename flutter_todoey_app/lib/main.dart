import 'package:flutter/material.dart';
import 'package:flutter_todoey_app/models/task_data.dart';
import 'package:provider/provider.dart';

import 'task_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
