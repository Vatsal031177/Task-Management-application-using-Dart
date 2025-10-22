import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final TaskService taskService;

  const HomeScreen({Key? key, required this.taskService}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filtering
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: widget.taskService.tasksStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                task: task,
                onToggle: (bool? value) {
                  final updatedTask = task.copyWith(isCompleted: value);
                  widget.taskService.updateTask(updatedTask);
                },
                onDelete: () {
                  widget.taskService.deleteTask(task.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(taskService: widget.taskService),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(bool?) onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onToggle,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
