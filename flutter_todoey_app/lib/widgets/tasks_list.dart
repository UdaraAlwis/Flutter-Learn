import 'package:flutter/material.dart';

import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TaskTile(
          title: 'This is task 1',
          isCompleted: true,
        ),
        TaskTile(
          title: 'This is task 2',
          isCompleted: true,
        ),
      ],
    );
  }
}
