import 'package:flutter/material.dart';
import 'blocs/TaskBlocProvider.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TaskBlocProvider.of(context).bloc;

  }
}
