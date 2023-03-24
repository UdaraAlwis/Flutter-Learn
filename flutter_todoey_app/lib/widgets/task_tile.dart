import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.title,
    required this.isCompleted,
  });

  final String title;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Checkbox(value: isCompleted, onChanged: (value) {}),
    );
  }
}
