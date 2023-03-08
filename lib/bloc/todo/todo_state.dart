part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoAddedState extends TodoState {}

class TodoUpdatedState extends TodoState {
  final TodoData updatedTodo;

  TodoUpdatedState(this.updatedTodo);
}

class TodoFetchedState extends TodoState {
  final List<TodoData> todos;

  TodoFetchedState(this.todos);
}

class NoTodoFoundState extends TodoState {}
