class Todo {
  final int userId ;
  final int id;
  final String title;
  final bool completed;



  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });

  //convert Todo - json
  Map<String ,dynamic> toJson() {
    return {
      'userId':userId,
      'id': id,
      'todo':title,
      'completed':completed,
    };
  }

  //convert json - Todo
  factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
        );
  }
  }




