import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController cropController = TextEditingController();
  String priority = 'Low'; // Default priority
  bool isRecurring = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: cropController,
              decoration: const InputDecoration(labelText: 'Crop (Optional)'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: priority,
              items: const [
                DropdownMenuItem(value: 'High', child: Text('High Priority')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium Priority')),
                DropdownMenuItem(value: 'Low', child: Text('Low Priority')),
              ],
              onChanged: (value) => setState(() => priority = value!),
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            SwitchListTile(
              title: const Text('Recurring Task'),
              value: isRecurring,
              onChanged: (value) => setState(() => isRecurring = value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  final task = Task(
                    title: taskController.text,
                    crop: cropController.text,
                    priority: priority,
                    isRecurring: isRecurring,
                  );
                  Navigator.pop(context, task);
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
