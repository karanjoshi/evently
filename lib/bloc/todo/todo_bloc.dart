import 'dart:async';

import 'package:evently/data/repository/todo_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/todo_data.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repo;

  TodoBloc(super.initialState, this._repo) {
    on<AddTodoEvent>(_onAddTodo);
    on<FetchTodoEvent>(_onFetchTodo);
    on<UpdateTodoEvent>(_onTodoUpdate);
  }

  FutureOr<void> _onFetchTodo(FetchTodoEvent event, Emitter<TodoState> emit) {
    List<TodoData> todos = _repo.getTodosByEvent(event.eventId);
    if (todos.isNotEmpty) {
      emit(TodoFetchedState(todos));
    } else {
      emit(NoTodoFoundState());
    }
  }

  FutureOr<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    _repo.add(event.todoData);
    emit(TodoAddedState());
    emit(TodoFetchedState(_repo.getTodosByEvent(event.todoData.eventId)));
  }

  String getTodoCounts(List<TodoData>? todos) {
    if (todos == null) {
      return "0/0";
    }
    int completedTodos = todos.where((element) => element.isCompleted).length;
    return "$completedTodos/${todos.length}";
  }

  FutureOr<void> _onTodoUpdate(UpdateTodoEvent event, Emitter<TodoState> emit) {
    _repo.update(event.updatedTodo);
    emit(TodoUpdatedState(event.updatedTodo));
  }
}
