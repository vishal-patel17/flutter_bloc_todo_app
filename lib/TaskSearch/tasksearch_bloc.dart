import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TasksearchBloc extends Bloc<TasksearchEvent, TasksearchState> {
  @override
  TasksearchState get initialState => InitialTasksearchState();

  @override
  Stream<TasksearchState> mapEventToState(
    TasksearchEvent event,
  ) async* {
    if (event is StartSearch) {
      yield* _mapStartSearchtoState();
    } else if (event is EndSearch) {
      yield* _mapEndSearchtoState();
    }
  }

  Stream<TasksearchState> _mapStartSearchtoState() async* {}

  Stream<TasksearchState> _mapEndSearchtoState() async* {}
}
