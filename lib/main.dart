import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc_demo/Task/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        cursorColor: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskBloc _taskBloc = TaskBloc();
  final TextEditingController _textController = new TextEditingController();

  @override
  void dispose() {
    _taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          mini: true,
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              _taskBloc.dispatch(AddTaskEvent(name: _textController.text));
              _textController.clear();
            } else {}
          }),
      body: Column(
        children: <Widget>[
          Flexible(
            child: BlocBuilder(
                bloc: _taskBloc,
                builder: (context, TaskState state) {
                  if (state is InitialTaskState) {
                    return taskList.isNotEmpty
                        ? ListView.builder(
                            itemCount: taskList.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.transparent,
                                  shape: OutlineInputBorder(),
                                  elevation: 0.0,
                                  child: ListTile(
                                    leading: Text(
                                      "${i + 1}.",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    title: Text(
                                      taskList[i],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(
                                          Icons.done,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          _taskBloc.dispatch(
                                              DeleteTaskEvent(index: i));
                                        }),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text('All Tasks completed!'),
                          );
                  }
                  return Center(
                    child: Text('All Tasks completed!'),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter task name',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
