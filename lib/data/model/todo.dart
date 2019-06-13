library todo;

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

@immutable
class ToDo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  ToDo(this.task, {this.complete = false, String note = '', String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),//automatically generates an unique id
        super([complete, id, note, task]);

  ToDo copyWith({bool complete, String id, String note, String task}) {// to be used when editing an ToDo
    return ToDo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  TodoEntity toEntity() {//to send ToDos to the Backend
    return TodoEntity(task, id, note, complete);
  }

  static ToDo fromEntity(TodoEntity entity) {
    return ToDo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
