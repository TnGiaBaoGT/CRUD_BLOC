
import 'package:api_crud/domain/todo_class.dart';

abstract class CrudStates{}

//initial
class CrudInitial extends CrudStates{}


//loading
class CrudLoading extends CrudStates{}


//loaded
class CrudLoaded extends CrudStates{
  final List<Todo> todo;
  CrudLoaded({required this.todo});
}

//success
class CrudSuccess extends CrudStates{
  final String mess;
  CrudSuccess ({required this.mess});
}

//errors
class CrudErrors extends CrudStates{
  final String mess;
  CrudErrors({required this.mess});
}