import 'package:evently/data/model/guest_data.dart';
import 'package:evently/data/repository/guest_repo.dart';
import 'package:evently/data/repository/person_repo.dart';
import 'package:evently/presentation/home/home_screen.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/person_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../theme/colors.dart';
import '../../../theme/decorations.dart';
import '../../../theme/fonts.dart';
import '../../data/model/person_data.dart';
import '../../widgets/back_button.dart';

class ContactListScreen extends ConsumerStatefulWidget {
  final String eventId;

  ContactListScreen({required this.eventId, Key? key}) : super(key: key);

  @override
  ConsumerState<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends ConsumerState<ContactListScreen> {
  List<PersonData> _list = [];

  @override
  void didChangeDependencies() {
    PersonRepository personRepository = ref.watch(personRepoProvider);
    _list = personRepository.getPersonList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppBackButton(),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Invite",
              textAlign: TextAlign.center,
              style: AppFonts.regular32,
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Container(
                padding: const EdgeInsets.all(40),
                decoration: AppDecorations.appBgShadow,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _list[index].isSelected =
                                  !_list[index].isSelected,
                              child: PersonListItem(
                                personData: _list[index],
                              ),
                            );
                          }),
                    ),
                    AppButton(
                        text: "Done",
                        onClick: () {
                          _inviteSelectedPersons(context);
                        })
                  ],
                )))
      ]),
    ));
  }

  void _inviteSelectedPersons(BuildContext context) {
    GuestRepository _guestRepo = ref.read(guestRepoProvider);
    Uuid uuid = const Uuid();
    _list.forEach((element) {
      if (element.isSelected) {
        _guestRepo.add(GuestData(
            uuid.v4(), widget.eventId, element.name, element.contactNo));
      }
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }
}
