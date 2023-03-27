import 'dart:collection';

import 'package:flutter/material.dart';

import 'model.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: 'Get milk', isDone: false),
    Task(name: 'Get sugar', isDone: false),
    Task(name: 'Get eggs', isDone: false),
  ];

  int get taskCount {
    return _tasks.length;
  }

  void addNewTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
