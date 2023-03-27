import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkBoxCallback;
  final VoidCallback onLongPressCallback;

  const TaskTile(
      {super.key,
      required this.taskTitle,
      required this.isChecked,
      required this.checkBoxCallback,
      required this.onLongPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value) => checkBoxCallback(value),
        activeColor: Colors.lightBlueAccent,
      ),
    );
  }
}
