import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_page.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = []; // List of tasks

  // Function to toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  // Navigate to Add Task Screen and handle the result
  void _navigateToAddTaskPage(BuildContext context) async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
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
        title: Text('Farm Task Tracker'),
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet. Add some!'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: task.crop.isNotEmpty ? Text('Crop: ${task.crop}') : null,
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) => _toggleTaskCompletion(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTaskPage(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
