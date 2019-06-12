// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:bloc_library/bloc/todos/todos.dart';
import 'package:bloc_library/meta/bloc_library_keys.dart';
import 'package:bloc_library/ui/screens/details_scrreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'LoadingIndicator.dart';
import 'TodoItem.dart';
import 'delete_todo_snack_bar.dart';


class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<ToDosBloc>(context);
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder(
      bloc: todosBloc,
      builder: (
          BuildContext context,
          ToDosState state,
          ) {
        if (state is ToDosLoading) {
          return LoadingIndicator(key: ArchSampleKeys.todosLoading);
        } else if (state is ToDosLoaded) {
          final todos = state.todos;
          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  todosBloc.dispatch(DeleteToDo(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: ArchSampleKeys.snackbar,
                    todo: todo,
                    onUndo: () => todosBloc.dispatch(AddToDo(todo)),
                    localizations: localizations,
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                      key: ArchSampleKeys.snackbar,
                      todo: todo,
                      onUndo: () => todosBloc.dispatch(AddToDo(todo)),
                      localizations: localizations,
                    ));
                  }
                },
                onCheckboxChanged: (_) {
                  todosBloc.dispatch(
                    UpdateToDo(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: BlocLibraryKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
