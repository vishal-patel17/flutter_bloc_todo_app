import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TasksearchEvent extends Equatable {
  TasksearchEvent([List props = const []]) : super(props);
}

class StartSearch extends TasksearchEvent {
  @override
  String toString() => 'StartSearch';
}

class EndSearch extends TasksearchEvent {
  @override
  String toString() => 'EndSearch';
}
