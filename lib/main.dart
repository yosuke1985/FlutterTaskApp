import 'package:flutter/material.dart';

void main() => runApp(TaskApp());

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task app',
      home: Tasks(),
      theme: ThemeData(primaryColor: Colors.grey),
    );
  }
}

class TasksState extends State<Tasks> {
  final _taskList = <String>[];
  final Set<String> _saved = Set<String>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final yeah = Text("yeah");
  TextEditingController _inputTaskField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task app'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      backgroundColor: Colors.grey,
      elevation: 0.0
      ),
      body: taskList(),
      backgroundColor: Colors.white,
    );
  }
  

  Widget taskList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i == 0) return TextField(
            controller: _inputTaskField,
            obscureText: false,
            onSubmitted: (String value){
              setState(() {              
              _taskList.add(value);
              _inputTaskField.text = "";
              });
            },
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '',
            hintText: 'Add a to-do',
            ),
          );
          
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          if (index >= 1 && index <= _taskList.length) {
            return _buildRow(_taskList[index-1]);
          } else {
            return ListTile(title: Text(""),);
          }
        });
  }

  Widget _buildRow(String taskName) {
    final bool alreadySaved = _saved.contains(taskName);
    return ListTile(
      title: Text(taskName,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.black: null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(taskName);
            print(_saved);
          } else {
            _saved.add(taskName);
            print(_saved);
          }
        }
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (String taskName) {
              return ListTile(
                title: Text(
                  taskName,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
            color : Colors.blueGrey,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Completed Tasks'),
              elevation: 0.0,
              backgroundColor: Colors.grey,
            ),
            body: ListView(children: divided),
            
          );
        },
      ),
    );
  }
}

class Tasks extends StatefulWidget {
  @override
  TasksState createState() => TasksState();
}