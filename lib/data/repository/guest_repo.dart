import 'package:evently/data/model/guest_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestRepoProvider = Provider((ref) => GuestRepository());

class GuestRepository {
  final List<GuestData> _guests = [];

  void add(GuestData guestData) {
    _guests.add(guestData);
  }

  void update(GuestData guestData) {
    _guests.removeWhere((element) => element.id == guestData.id);
    _guests.add(guestData);
  }

  void remove(String id) {
    _guests.removeWhere((element) => element.id == id);
  }

  List<GuestData> getGuestsByEvent(String eventId) {
    return _guests.where((element) => element.eventId == eventId).toList();
  }
}
