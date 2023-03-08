part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoData todoData;

  AddTodoEvent(this.todoData);
}

class FetchTodoEvent extends TodoEvent {
  final String eventId;

  FetchTodoEvent(this.eventId);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoData updatedTodo;

  UpdateTodoEvent(this.updatedTodo);
}
