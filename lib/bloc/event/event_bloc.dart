import 'package:bloc/bloc.dart';
import 'package:evently/data/model/event_data.dart';
import 'package:evently/data/repository/event_repo.dart';
import 'package:flutter/material.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _repo = EventRepository();

  EventBloc(super.initialState) {
    on<AddEventDataEvent>(_onAddEventData);
  }

  _onAddEventData(
      AddEventDataEvent addEventDataEvent, Emitter<EventState> emitter) {
    if (addEventDataEvent.date == null) {
      emitter(InvalidEventDataState("Please select date of event"));
    } else if (addEventDataEvent.time == null) {
      emitter(InvalidEventDataState("Please select time of event"));
    } else {
      DateTime date = addEventDataEvent.date!;
      TimeOfDay time = addEventDataEvent.time!;
      EventData eventData = EventData(
          "123",
          addEventDataEvent.title,
          addEventDataEvent.description,
          DateTime(date.year, date.month, date.day, time.hour, time.minute));
      _repo.add(eventData);
      emitter(EventAddedState(eventData));
    }
  }
}
