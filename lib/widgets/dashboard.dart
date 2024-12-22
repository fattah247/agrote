import 'package:flutter/material.dart';
import '../models/task.dart';

class Dashboard extends StatelessWidget {
  final List<Task> tasks;

  const Dashboard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final int totalTasks = tasks.length;
    final int completedTasks = tasks.where((task) => task.isDone).length;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Total Tasks: $totalTasks'),
            Text('Completed Tasks: $completedTasks'),
            Text('Pending Tasks: ${totalTasks - completedTasks}'),
          ],
        ),
      ),
    );
  }
}
