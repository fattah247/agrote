import 'package:agrote/screens/task_list_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Agrote());


class Agrote extends StatelessWidget {
  const Agrote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrote',
      theme: ThemeData(primarySwatch: Colors.green),
      home: TaskListPage(),
    );
  }
}
