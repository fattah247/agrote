import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdateTask;

  TaskDetailPage({required this.task, required this.onUpdateTask});

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isDone;
  }

  void _markAsCompleted() {
    setState(() {
      isCompleted = true;
    });
    widget.onUpdateTask(widget.task..isDone = true); // Update parent state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Crop: ${widget.task.crop.isNotEmpty ? widget.task.crop : 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Status: ${isCompleted ? "Completed" : "Pending"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isCompleted
                  ? null // Disable button if already completed
                  : _markAsCompleted,
              child: Text(isCompleted ? 'Task Completed' : 'Mark as Completed'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
