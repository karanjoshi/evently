part of 'person_bloc.dart';

abstract class PersonState {}

class PersonListLoadingState extends PersonState {}

class PersonListFetchedState extends PersonState {
  final List<PersonData> list;

  PersonListFetchedState(this.list);
}

class PersonListFetchErrorState extends PersonState {
  final String message;

  PersonListFetchErrorState(this.message);
}

class NoPersonFoundState extends PersonState {}
