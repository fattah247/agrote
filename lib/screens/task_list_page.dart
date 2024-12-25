import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import 'task_detail_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Task> tasks = [];

  // Navigate to Add/Edit Task Screen
  Future<void> _navigateToAddOrEditTask(Task? task) async {
    final Task? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(existingTask: task),
      ),
    );
    if (result != null) {
      setState(() {
        if (task == null) {
          tasks.add(result); // Add new task
        } else {
          // Update existing task
          final index = tasks.indexOf(task);
          tasks[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks yet.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text('Priority: ${task.priority}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _navigateToAddOrEditTask(task),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailPage(
                          task: task,
                          onUpdateTask: (updatedTask) {
                            setState(() {
                              tasks[index] = updatedTask; // Update the task
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddOrEditTask(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
