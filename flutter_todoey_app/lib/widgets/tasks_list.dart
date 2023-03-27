import 'package:flutter/material.dart';
import 'package:flutter_todoey_app/models/task_data.dart';
import 'package:provider/provider.dart';

import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];

            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkBoxCallback: (isChecked) {
                taskData.updateTask(task);
              },
              onLongPressCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
