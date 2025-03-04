abstract class CrudEvents{}

class FetchData extends CrudEvents{}


class DeleteData extends CrudEvents{
  final int idTodo;
  DeleteData({required this.idTodo});
}

class PostData extends CrudEvents{
  final int userId;
  final String title;
  final bool completed;
  PostData({
    required this.userId,
    required this.title,
    required this.completed,
});
}


class UpdateData extends CrudEvents{
  final int id;
  final int userId;
  final String newTitle;
  final bool isCompleted;

  UpdateData({
    required this.id,
    required this.userId,
    required this.newTitle,
    required this.isCompleted,
});
}