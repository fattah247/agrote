class Task {
  final String title;
  final String crop;
  final String priority; // High, Medium, Low
  bool isDone;
  final bool isRecurring; // Indicates if the task repeats
  final DateTime? dueDate; // Optional due date

  Task({
    required this.title,
    this.crop = '',
    this.priority = 'Low',
    this.isDone = false,
    this.isRecurring = false,
    this.dueDate,
  });
}
