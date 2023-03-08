import 'package:evently/data/model/guest_data.dart';
import 'package:evently/data/model/todo_data.dart';

class EventData {
  final String id;
  final String title;
  final String description;
  final DateTime datetime;

  List<TodoData>? todos;
  List<GuestData>? guests;

  EventData(this.id, this.title, this.description, this.datetime);
}
