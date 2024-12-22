import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/notification_service.dart';
import '../widgets/task_item.dart';
import '../widgets/dashboard.dart';
import 'task_detail_page.dart';
import 'add_task_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Task> tasks = [];
  final NotificationService notificationService = NotificationService();

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
    if (tasks[index].isDone) {
      notificationService.showNotification(
        'Task Completed',
        'You have completed "${tasks[index].title}"',
      );
    }
  }

  void _navigateToAddTaskPage() async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );
    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agrote'),
      ),
      body: Column(
        children: [
          Dashboard(tasks: tasks), // Add the dashboard widget
          Expanded(
            child: tasks.isEmpty
                ? const Center(
              child: Text(
                'No tasks yet. Add some!',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(
                  task: task,
                  onToggle: () => _toggleTaskCompletion(index),
                  onViewDetails: () => _viewTaskDetails(task),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTaskPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _viewTaskDetails(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(
          task: task,
          onUpdateTask: (updatedTask) {
            setState(() {
              final index = tasks.indexOf(task);
              if (index != -1) {
                tasks[index] = updatedTask;
              }
            });
          },
        ),
      ),
    );
  }
}
