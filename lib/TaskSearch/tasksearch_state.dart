import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TasksearchState extends Equatable {
  TasksearchState([List props = const []]) : super(props);
}

class InitialTasksearchState extends TasksearchState {}

class SearchStateEmpty extends TasksearchState {
  @override
  String toString() => 'SearchStateEmpty';
}

class SearchStateLoading extends TasksearchState {
  @override
  String toString() => 'SearchStateLoading';
}

class SearchStateSuccess extends TasksearchState {
  @override
  String toString() => 'SearchStateSuccess';
}

class SearchStateError extends TasksearchState {
  @override
  String toString() => 'SearchStateError';
}
