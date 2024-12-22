import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onViewDetails;

  const TaskItem({super.key,
    required this.task,
    required this.onToggle,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: task.crop.isNotEmpty ? Text('Crop: ${task.crop}') : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onViewDetails,
          ),
          Checkbox(
            value: task.isDone,
            onChanged: (value) => onToggle(),
          ),
        ],
      ),
    );
  }
}
