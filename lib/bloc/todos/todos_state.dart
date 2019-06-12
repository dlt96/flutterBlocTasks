
import 'package:bloc_library/data/model/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class ToDosState extends Equatable {
  //Note: We are annotating our base TodosState with the immutable decorator
  // so that we can indicate that all TodosStates cannot be changed.

  ToDosState([List props = const []]) : super(props);//properties to be evaluated for Equ.
}

class ToDosLoading extends ToDosState {

  @override
  String toString() => 'TodosLoading';
}

class ToDosLoaded extends ToDosState {
  final List<ToDo> todos;

  ToDosLoaded([this.todos = const []]) : super ([todos]);

  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}

class ToDosNotLoaded extends ToDosState {
  @override
  String toString() => 'TodosNotLoaded';
}


