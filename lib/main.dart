import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(TaskApp());

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task app',
      home: Tasks(),
    );
  }
}

class TasksState extends State<Tasks> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final yeah = Text("yeah");

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
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          print("index${index}");
          print("i${i}");
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red: null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
            print(_saved);
          } else {
            _saved.add(pair);
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
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
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
              title: Text('Saved Tasks'),
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