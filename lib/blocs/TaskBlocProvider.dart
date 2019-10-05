import 'package:flutter/material.dart';
import 'TaskBloc.dart';
export 'TaskBloc.dart';

class TaskBlocProvider extends InheritedWidget {
  const TaskBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  TaskBloc get bloc => TaskBloc();

  @override
  bool updateShouldNotify(oldWidget) => false;
  static TaskBlocProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TaskBlocProvider);
  }
}
