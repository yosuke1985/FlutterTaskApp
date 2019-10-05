import 'package:flutter/material.dart';
import 'package:my_app/TaskListView.dart';
import 'blocs/TaskBlocProvider.dart';

void main() => runApp(TaskApp());

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task app',
      home: TaskBlocProvider(
        child: TaskListView()
      ),
      theme: ThemeData(primaryColor: Colors.orange),
    );
  }
}