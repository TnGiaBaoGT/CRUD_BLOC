import 'dart:convert';
import 'package:api_crud/crud/crud_bloc_events.dart';
import 'package:api_crud/crud/crud_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../domain/todo_class.dart';

class CrudBloc extends Bloc<CrudEvents, CrudStates> {
  CrudBloc() : super(CrudInitial()) {
    // Register the FetchData event handler
    on<FetchData>((event, emit) async {
      emit(CrudLoading());
      try {
        final response = await http.get(
            Uri.parse('https://jsonplaceholder.typicode.com/todos'));
        if (response.statusCode == 200) {
          // Decode the JSON data
          final result = jsonDecode(response.body);
          //print(result);
          // Convert JSON data to a list of Todo objects
          final todos = (result as List)
              .map((e) => Todo.fromJson(e))
              .toList();
          // Emit the CrudLoaded state with the todos list
          emit(CrudLoaded(todo: todos));
        } else {
          emit(CrudErrors(mess: 'Failed to get response.'));
        }
      } catch (e) {
        emit(CrudErrors(mess: 'Error: $e'));
      }
    });


    // on<FetchData>((event, emit) async {
    //   emit(CrudLoading());
    //   try {
    //     final response = await http.get(
    //         Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    //     if (response.statusCode == 200) {
    //       // Decode the JSON data
    //       final result = jsonDecode(response.body);
    //       print(result); // Debug print to see the response structure
    //
    //       // Since the response is a single object, map it to a Todo object
    //       final todo = Todo.fromJson(result);
    //
    //       // Emit the CrudLoaded state with the single Todo object in a list
    //       emit(CrudLoaded(todo: [todo]));  // Wrap the single todo in a list
    //     } else {
    //       emit(CrudErrors(mess: 'Failed to get response.'));
    //     }
    //   } catch (e) {
    //     emit(CrudErrors(mess: 'Error: $e'));
    //   }
    // });



    on<DeleteData>((event, emit) async {
      emit(CrudLoading());
      try {
        final response = await http.delete(
            Uri.parse('https://jsonplaceholder.typicode.com/todos/${event.idTodo}')
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          // After deletion, trigger FetchData event to refresh the list
          //emit(CrudSuccess(mess: 'Deleted successfully.'));
          add(FetchData());
        } else {
          emit(CrudErrors(mess: 'Failed to delete.'));
        }
      } catch (e) {
        emit(CrudErrors(mess: 'Error: $e'));
      }
    });


    on<PostData>((event, emit) async{
      emit(CrudLoading());
      try{
        final reponse = await http.post(
          Uri.parse('https://jsonplaceholder.typicode.com/todos'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': event.userId,
            'title': event.title,
            'completed': event.completed,
          }),
        );
        if (reponse.statusCode == 201){
          final result = jsonDecode(reponse.body);
          print('Todo created: $result , ${reponse.statusCode}');
          add(FetchData());
        }
        else{
          print(reponse.statusCode);
          emit(CrudErrors(mess: 'Failed to create todos.'));
        }
      }
      catch(e){
        emit(CrudErrors(mess: 'Errors: $e'));
      }
    });


    on<UpdateData>((event,emit) async {
      emit(CrudLoading());
      try{
        final reponse = await http.put(
          Uri.parse('https://jsonplaceholder.typicode.com/todos/${event.id}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId':event.userId,
            'id': event.id,
            'title':event.newTitle,
            'completed':event.isCompleted,
          }),
        );
        if (reponse.statusCode == 200){
          final result = jsonDecode(reponse.body);
          print('Todo updated: $result , ${reponse.statusCode}');
          add(FetchData());
        }
        else{
          print(reponse.statusCode);
          emit(CrudErrors(mess: 'Failed to update todos.'));
        }
      }
      catch(e){
        emit(CrudErrors(mess: 'Errors:$e'));
      }
    });

  }
  }
