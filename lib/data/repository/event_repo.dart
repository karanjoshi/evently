import 'package:evently/data/model/event_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventRepoProvider = Provider((ref) => EventRepository());

class EventRepository {
  final List<EventData> _events = [];

  void add(EventData eventData) {
    _events.add(eventData);
  }

  void update(EventData eventData) {
    _events.removeWhere((element) => element.id == eventData.id);
    _events.add(eventData);
  }

  void remove(String id) {
    _events.removeWhere((element) => element.id == id);
  }

  List<EventData> getEvents() {
    return _events;
  }

  EventData getEventById(String id) {
    return _events.singleWhere((element) => element.id == id);
  }
}
