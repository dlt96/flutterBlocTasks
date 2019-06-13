import 'package:bloc_library/bloc/todos/todos_bloc.dart';
import 'package:bloc_library/meta/localization.dart';
import 'package:bloc_library/ui/widgets/filtered_todos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';


class HomeScreen extends StatefulWidget {

  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: ArchSampleKeys.homeScreen);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  ToDosBloc _toDosBloc;

  @override
  void initState() {
    widget.onInit();
    _toDosBloc = BlocProvider.of<ToDosBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      bloc: _toDosBloc,
      child: _buildScaffold(),
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterBlocLocalizations.of(context).appTitle),
      ),
      body: FilteredTodos(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addTodo);//navigate to route
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addTodo,
      ),
    );
  }

}

