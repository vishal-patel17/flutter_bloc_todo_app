import 'package:meta/meta.dart';

@immutable
abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String name;
  AddTaskEvent({@required this.name});
  @override
  String toString() => 'AddTaskEvent { name: $name}';
}

class DeleteTaskEvent extends TaskEvent {
  final String index;
  DeleteTaskEvent({@required this.index});
  @override
  String toString() => 'DeleteTaskEvent{ index: $index}';
}
