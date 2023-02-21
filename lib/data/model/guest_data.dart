import 'package:evently/data/model/person_data.dart';

class GuestData extends PersonData {
  final String id;
  final String eventId;

  GuestData(this.id, this.eventId, super.name, super.contactNo);
}
