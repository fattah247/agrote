import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_detail_page.dart';
import 'add_task_page.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Task> tasks = [];

  // Function to toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _viewTaskDetails(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(
          task: task,
          onUpdateTask: (updatedTask) {
            setState(() {
              // Find the task in the list and update its state
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

  void _navigateToAddTaskPage() async {
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
          ? Center(
        child: Text(
          'No tasks yet. Add some!',
          style: TextStyle(fontSize: 18),
        ),
      )
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Ensures the row takes minimal space
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => _viewTaskDetails(task),
                  tooltip: 'View Details',
                ),
                Checkbox(
                  value: task.isDone,
                  onChanged: (value) => _toggleTaskCompletion(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTaskPage,
        child: Icon(Icons.add),
      ),
    );
  }

}
