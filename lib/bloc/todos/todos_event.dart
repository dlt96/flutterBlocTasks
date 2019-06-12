import 'package:bloc_library/data/model/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';



@immutable
abstract class ToDosEvent extends Equatable {
  ToDosEvent([List props = const []]) : super(props);
}

class LoadToDos extends ToDosEvent {
  @override
  String toString() => 'LoadTodos';
}

class AddToDo extends ToDosEvent {
  final ToDo todo;

  AddToDo(this.todo) : super([todo]);

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class UpdateToDo extends ToDosEvent {
  final ToDo updatedTodo;

  UpdateToDo(this.updatedTodo) : super([updatedTodo]);

  @override
  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
}

class DeleteToDo extends ToDosEvent {
  final ToDo todo;

  DeleteToDo(this.todo) : super([todo]);

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
}

class ClearCompleted extends ToDosEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends ToDosEvent {
  @override
  String toString() => 'ToggleAll';
}
