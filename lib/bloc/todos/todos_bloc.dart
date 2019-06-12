import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_library/data/model/todo.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'todos_event.dart';
import 'todos_state.dart';



class ToDosBloc extends Bloc<ToDosEvent, ToDosState> {
  final TodosRepositoryFlutter todosRepository;//dummy web and json storage repo.

  ToDosBloc({@required this.todosRepository});

  @override
  ToDosState get initialState => ToDosLoading();

  @override
  Stream<ToDosState> mapEventToState(ToDosEvent event) async* {
    if (event is LoadToDos) {
      yield* _mapLoadToDosToState();
    } else if (event is AddToDo) {
      yield* _mapAddToDoToState(event);
    } else if (event is UpdateToDo) {
      yield* _mapUpdateToDoToState(event);
    } else if (event is DeleteToDo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }


 Stream<ToDosState> _mapLoadToDosToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield ToDosLoaded (
        todos.map(ToDo.fromEntity).toList(),
      );
    } catch (_) {
      yield ToDosNotLoaded();//it should be error state...
    }
 }

  Stream<ToDosState> _mapAddToDoToState(AddToDo event) async* {
    if (currentState is ToDosLoaded) {//We can always access current state
      final List<ToDo> updatedTodos =
      List.from((currentState as ToDosLoaded).todos)..add(event.todo);
      yield ToDosLoaded(updatedTodos);
      _saveToDos(updatedTodos);
    }
  }

  Stream<ToDosState> _mapUpdateToDoToState(UpdateToDo event) async* {
    if (currentState is ToDosLoaded) {
      final List<ToDo> updatedTodos =
      (currentState as ToDosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield ToDosLoaded(updatedTodos);
      _saveToDos(updatedTodos);
    }
  }

  Stream<ToDosState> _mapDeleteTodoToState(DeleteToDo event) async* {
    if (currentState is ToDosLoaded) {
      final updatedTodos = (currentState as ToDosLoaded)
          .todos
          .where((todo) => todo.id != event.todo.id)//change to todos.remove(object) TODO?
          .toList();
      yield ToDosLoaded(updatedTodos);
      _saveToDos(updatedTodos);
    }
  }

  Stream<ToDosState> _mapToggleAllToState() async* {
    if (currentState is ToDosLoaded) {
      final allComplete =
      (currentState as ToDosLoaded).todos.every((todo) => todo.complete);
      final List<ToDo> updatedTodos = (currentState as ToDosLoaded)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield ToDosLoaded(updatedTodos);
      _saveToDos(updatedTodos);
    }
  }

  Stream<ToDosState> _mapClearCompletedToState() async* {
    if (currentState is ToDosLoaded) {
      final List<ToDo> updatedTodos = (currentState as ToDosLoaded)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      yield ToDosLoaded(updatedTodos);
      _saveToDos(updatedTodos);
    }
  }

  Future _saveToDos(List<ToDo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }

}