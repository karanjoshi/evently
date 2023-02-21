import 'package:evently/data/model/todo_data.dart';

class TodoRepository {
  final List<TodoData> _todos = [];

  void add(TodoData todoData) {
    _todos.add(todoData);
  }

  void update(TodoData todoData) {
    _todos.removeWhere((element) => element.id == todoData.id);
    _todos.add(todoData);
  }

  void remove(String id) {
    _todos.removeWhere((element) => element.id == id);
  }

  List<TodoData> getTodosByEvent(String eventId) {
    return _todos.where((element) => element.eventId == eventId).toList();
  }
}
