import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evently/data/model/event_data.dart';
import 'package:evently/data/repository/event_repo.dart';
import 'package:evently/data/repository/guest_repo.dart';
import 'package:evently/data/repository/todo_repo.dart';
import 'package:flutter/material.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepo;
  final GuestRepository guestRepo;
  final TodoRepository todoRepo;

  EventBloc(super.initialState,
      {required this.eventRepo,
      required this.todoRepo,
      required this.guestRepo}) {
    on<AddEventDataEvent>(_onAddEventData);
    on<FetchEventsEvent>(_onFetchEvents);
    on<FetchEventDetailsEvent>(_onFetchEventDetails);
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
      eventRepo.add(eventData);
      emitter(EventAddedState(eventData));
    }
  }

  FutureOr<void> _onFetchEvents(
      FetchEventsEvent event, Emitter<EventState> emit) {
    List<EventData> events = eventRepo.getEvents();
    if (events.isNotEmpty) {
      for (var event in events) {
        event.guests = guestRepo.getGuestsByEvent(event.id);
        event.todos = todoRepo.getTodosByEvent(event.id);
      }
      emit(EventFetchedState(events));
    } else {
      emit(NoEventsFoundState());
    }
  }


  FutureOr<void> _onFetchEventDetails(
      FetchEventDetailsEvent event, Emitter<EventState> emit) {
    try {
      EventData? eventData = eventRepo.getEventById(event.id);
      eventData.guests = guestRepo.getGuestsByEvent(event.id);
      eventData.todos = todoRepo.getTodosByEvent(event.id);
      emit(EventDetailFetchedState(eventData));
    } catch (e) {
      emit(NoEventsFoundState());
    }
  }
}
