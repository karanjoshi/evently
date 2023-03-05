import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evently/data/repository/person_repo.dart';

import '../../data/model/person_data.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository _repo = PersonRepository();

  PersonBloc(super.initialState) {
    on<FetchPersonListEvent>(_onFetchPersonListEvent);
  }

  FutureOr<void> _onFetchPersonListEvent(
      FetchPersonListEvent event, Emitter<PersonState> emit) {
    try {
      List<PersonData> personList = _repo.getPersonList();
      if (personList.isNotEmpty) {
        emit(PersonListFetchedState(personList));
      } else {
        emit(NoPersonFoundState());
      }
    } catch (e) {
      emit(PersonListFetchErrorState(e.toString()));
    }
  }
}
