import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  @override
  TaskState get initialState => InitialTaskState();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is AddTaskEvent) {
      yield* _mapAddTasktoState(event.name);
    } else if (event is DeleteTaskEvent) {
      yield* _mapDeleteTasktoState(event.index);
    }
  }

  Stream<TaskState> _mapAddTasktoState(String name) async* {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('tasks');
      await reference.add({
        "name": name,
      });
    });
//    taskList.add(name);
    yield InitialTaskState();
  }

  Stream<TaskState> _mapDeleteTasktoState(String index) async* {
    await Firestore.instance.collection('tasks').document(index).delete();
//    taskList.removeAt(index);
    yield InitialTaskState();
  }
}
