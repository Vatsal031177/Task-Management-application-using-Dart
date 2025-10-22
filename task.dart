class Task {
  final String id;
  String title;
  String description;
  bool isCompleted;
  DateTime dueDate;
  Priority priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
    this.priority = Priority.medium,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    Priority? priority,
  }) {
    return Task(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }
}

enum Priority { low, medium, high }
