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
      child: Column(
        children: [
          ListTile(
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TaskTimer(dueDate: task.dueDate),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          if (!task.isCompleted && task.dueDate.isAfter(DateTime.now()))
            TaskTimer(dueDate: task.dueDate),
        ],
      ),
    );
  }
}
