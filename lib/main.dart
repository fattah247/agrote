import 'package:agrote/screens/task_list_page.dart';
import 'package:agrote/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Agrote());


class Agrote extends StatelessWidget {
  const Agrote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrote',
      theme: AppTheme.lightTheme,
      home: TaskListPage(),
    );
  }
}
