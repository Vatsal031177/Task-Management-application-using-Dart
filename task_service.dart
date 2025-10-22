import 'dart:async';
import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];
  final _taskController = StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get tasksStream => _taskController.stream;

  void addTask(Task task) {
    _tasks.add(task);
    _taskController.add(_tasks);
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      _taskController.add(_tasks);
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _taskController.add(_tasks);
  }

  List<Task> getTasks() => List.unmodifiable(_tasks);

  void dispose() {
    _taskController.close();
  }
}
