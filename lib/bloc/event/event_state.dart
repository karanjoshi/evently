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
