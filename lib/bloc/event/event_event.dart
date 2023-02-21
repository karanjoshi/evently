part of 'event_bloc.dart';

abstract class EventEvent {}

class AddEventDataEvent extends EventEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final String title;
  final String description;

  AddEventDataEvent({
    required this.title,
    required this.description,
    this.date,
    this.time,
  });
}