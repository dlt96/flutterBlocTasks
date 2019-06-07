// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ToDo extends ToDo {
  factory _$ToDo([void Function(ToDoBuilder) updates]) =>
      (new ToDoBuilder()..update(updates)).build();

  _$ToDo._() : super._();

  @override
  ToDo rebuild(void Function(ToDoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ToDoBuilder toBuilder() => new ToDoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ToDo;
  }

  @override
  int get hashCode {
    return 615094898;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ToDo').toString();
  }
}

class ToDoBuilder implements Builder<ToDo, ToDoBuilder> {
  _$ToDo _$v;

  ToDoBuilder();

  @override
  void replace(ToDo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ToDo;
  }

  @override
  void update(void Function(ToDoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ToDo build() {
    final _$result = _$v ?? new _$ToDo._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
