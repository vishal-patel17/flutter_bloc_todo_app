import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  @override
  TaskState get initialState => UnInitialTaskState();

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
    taskList.add(name);
    yield InitialTaskState();
  }

  Stream<TaskState> _mapDeleteTasktoState(int index) async* {
    taskList.removeAt(index);
    yield InitialTaskState();
  }
}
