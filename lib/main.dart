// Flutter code sample for material.FloatingActionButton.1

// This example shows how to make a simple [FloatingActionButton] in a
// [Scaffold], with a pink [backgroundColor] and a thumbs up [Icon].

import 'package:bloc_library/meta/localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'bloc/todos/todos.dart';
import 'data/model/todo.dart';
import 'delegates/simple_bloc_delegate.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'ui/screens/add_edit_screen.dart';
import 'ui/screens/home_screen.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  final todosBloc = ToDosBloc(
    todosRepository: const TodosRepositoryFlutter(
      fileStorage: const FileStorage(
        '__flutter_bloc_app__',
        getApplicationDocumentsDirectory,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: todosBloc,
      child: MaterialApp(
        title: FlutterBlocLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              onInit: () => todosBloc.dispatch(LoadToDos()),
            );
          },
          ArchSampleRoutes.addTodo: (context) {
            return AddEditScreen(
              key: ArchSampleKeys.addTodoScreen,
              onSave: (task, note) {
                todosBloc.dispatch(
                  AddToDo(ToDo(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}