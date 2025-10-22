import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/task_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskService taskService = TaskService();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(taskService: taskService),
    );
  }
}
