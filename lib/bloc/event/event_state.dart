part of 'event_bloc.dart';

abstract class EventState {}

class InitialEventState extends EventState {}

class InvalidEventDataState extends EventState {
  final String errorMsg;

  InvalidEventDataState(this.errorMsg);
}

class EventAddedState extends EventState {
  final EventData eventData;

  EventAddedState(this.eventData);
}

class EventFetchedState extends EventState {
  final List<EventData> events;

  EventFetchedState(this.events);
}

class NoEventsFoundState extends EventState {}

class EventDetailFetchedState extends EventState {
  final EventData eventData;

  EventDetailFetchedState(this.eventData);
}
