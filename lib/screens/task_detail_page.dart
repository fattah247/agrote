import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onUpdateTask; // Callback for updating the task

  const TaskDetailPage(
      {required this.task, required this.onUpdateTask, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Crop: ${task.crop.isNotEmpty ? task.crop : 'None'}'),
            Text('Priority: ${task.priority}'),
            Text('Status: ${task.isDone ? 'Completed' : 'Pending'}'),
            Text('Recurring: ${task.isRecurring ? 'Yes' : 'No'}'),
            if (task.dueDate != null)
              Text('Due Date: ${task.dueDate.toString().split(' ')[0]}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Toggle task completion and call the callback
                final updatedTask = Task(
                  title: task.title,
                  crop: task.crop,
                  priority: task.priority,
                  isDone: !task.isDone,
                  // Toggle status
                  isRecurring: task.isRecurring,
                  dueDate: task.dueDate,
                );
                onUpdateTask(updatedTask); // Call the callback
                Navigator.pop(context); // Go back to the task list
              },
              child:
                  Text(task.isDone ? 'Mark as Pending' : 'Mark as Completed'),
            ),
          ],
        ),
      ),
    );
  }
}
