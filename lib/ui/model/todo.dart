library todo;

import 'package:built_value/built_value.dart';

part 'todo.g.dart';

abstract class ToDo implements Built<ToDo, ToDoBuilder> {
 //ToDo: fields go here
            
 ToDo._();
            
 factory ToDo([updates(ToDoBuilder b)]) = _$ToDo;
}