import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloc_demo/Task/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.deepPurple,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              _taskBloc.dispatch(AddTaskEvent(name: _textController.text));
              _textController.clear();
            } else {}
          }),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/done.png',
              fit: BoxFit.cover,
              color: Color.fromRGBO(255, 255, 255, 0.3),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          Column(
            children: <Widget>[
              Flexible(
                child: BlocBuilder(
                    bloc: _taskBloc,
                    builder: (context, TaskState state) {
                      if (state is InitialTaskState) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('tasks')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            if (!snapshot.hasData)
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              );
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                );
                              default:
                                print(snapshot.data.documents.length);
                                return snapshot.data.documents.length > 0
                                    ? ListView(
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              color: Colors.transparent,
                                              shape: OutlineInputBorder(),
                                              elevation: 0.0,
                                              child: ListTile(
                                                leading: Text(
                                                  "${snapshot.data.documents.indexOf(document) + 1}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                title: Text(
                                                  document['name'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                    icon: Icon(
                                                      Icons.done,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      _taskBloc.dispatch(
                                                          DeleteTaskEvent(
                                                              index: document
                                                                  .documentID));
                                                    }),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )
                                    : Center(
                                        child: Text(
                                          'All Tasks Completed!',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                            }
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          'All Tasks Completed!',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter task name',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
