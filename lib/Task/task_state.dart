import 'package:meta/meta.dart';

@immutable
abstract class TaskState {}

class UnInitialTaskState extends TaskState {}

class InitialTaskState extends TaskState {}
