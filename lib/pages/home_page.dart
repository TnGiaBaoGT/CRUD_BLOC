import 'package:api_crud/crud/crud_bloc.dart';
import 'package:api_crud/crud/crud_bloc_events.dart';
import 'package:api_crud/crud/crud_bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Trigger the initial fetch
    context.read<CrudBloc>().add(FetchData());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List'),
      ),
      body: BlocBuilder<CrudBloc, CrudStates>(
        builder: (context, state) {
          print(state);
          if (state is CrudLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CrudLoaded) {
            return ListView.builder(
              itemCount: state.todo.length,
              itemBuilder: (context, index) {
                final todoItem = state.todo[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(todoItem.id.toString()),
                            Text(todoItem.title),
                            Text(
                              todoItem.completed ? 'Done' : 'None',
                              style: TextStyle(
                                color: todoItem.completed
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                             context.read<CrudBloc>().add(DeleteData(idTodo: todoItem.id));// Delete the item

                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(onPressed: () {
                          context.read<CrudBloc>().add(PostData(
                              userId: todoItem.userId,
                              title: 'Tesst',
                              completed: true,
                          ));
                        },
                            icon: Icon(Icons.add)),
                        IconButton(onPressed: () {
                          context.read<CrudBloc>().add(UpdateData(
                            id: todoItem.id,
                            userId: todoItem.userId,
                            newTitle: 'Tesst',
                            isCompleted: true,
                          ));
                        },
                            icon: Icon(Icons.update)),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (state is CrudErrors) {
            return Center(child: Text(state.mess));
          }
          return Center(child: Text('Error getting data.'));
        },
      ),
    );
  }
}

