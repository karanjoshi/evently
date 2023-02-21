import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/person_data.dart';

final personRepoProvider = Provider((ref) => PersonRepository());

class PersonRepository {
  final List<PersonData> _dummyContacts = [
    PersonData("John Doe", "+91 90909 90900"),
    PersonData("John Doe", "+91 90909 90900"),
    PersonData("John Doe", "+91 90909 90900"),
    PersonData("John Doe", "+91 90909 90900"),
  ];

  List<PersonData> getPersonList() {
    return _dummyContacts;
  }
}
