import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  final Task? existingTask; // Pass an existing task for editing

  const AddTaskPage({this.existingTask, super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController cropController = TextEditingController();
  String priority = 'Low'; // Default priority
  bool isRecurring = false;
  DateTime? selectedDueDate;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      // Populate fields with existing task data
      taskController.text = widget.existingTask!.title;
      cropController.text = widget.existingTask!.crop;
      priority = widget.existingTask!.priority;
      isRecurring = widget.existingTask!.isRecurring;
      selectedDueDate = widget.existingTask!.dueDate;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDueDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTask == null ? 'Add New Task' : 'Edit Task'),
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
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: priority,
              onChanged: (value) {
                setState(() {
                  priority = value!;
                });
              },
              items: ['High', 'Medium', 'Low']
                  .map((priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority),
              ))
                  .toList(),
            ),
            Row(
              children: [
                const Text('Is Recurring?'),
                Checkbox(
                  value: isRecurring,
                  onChanged: (value) {
                    setState(() {
                      isRecurring = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(selectedDueDate == null
                    ? 'No due date set'
                    : 'Due Date: ${selectedDueDate.toString().split(' ')[0]}'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  final task = Task(
                    title: taskController.text,
                    crop: cropController.text,
                    priority: priority,
                    isRecurring: isRecurring,
                    dueDate: selectedDueDate,
                  );
                  Navigator.pop(context, task);
                }
              },
              child: Text(widget.existingTask == null ? 'Add Task' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
