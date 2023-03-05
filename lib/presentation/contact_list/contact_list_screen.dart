import 'package:evently/bloc/guest/guest_bloc.dart';
import 'package:evently/bloc/person/person_bloc.dart';
import 'package:evently/data/model/guest_data.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/person_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../theme/colors.dart';
import '../../../theme/decorations.dart';
import '../../../theme/fonts.dart';
import '../../data/model/person_data.dart';
import '../../widgets/back_button.dart';
import '../home/home_screen.dart';

class ContactListScreen extends StatelessWidget {
  final String eventId;

  ContactListScreen({required this.eventId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GuestBloc, GuestState>(
      listener: (BuildContext context, state) {
        if (state is GuestInvitedState) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        }
      },
      child: SafeArea(
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
                    child: BlocBuilder<PersonBloc, PersonState>(
                      bloc: PersonBloc(PersonListLoadingState())
                        ..add(FetchPersonListEvent()),
                      builder: (BuildContext context, state) {
                        if (state is PersonListFetchedState) {
                          return Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                    itemCount: state.list.length,
                                    itemBuilder: (context, index) {
                                      return PersonListItem(
                                        personData: state.list[index],
                                      );
                                    }),
                              ),
                              AppButton(
                                  text: "Done",
                                  onClick: () {
                                    _inviteSelectedPersons(context, state);
                                  })
                            ],
                          );
                        } else if (state is NoPersonFoundState) {
                          return Center(
                            child: Text(
                              "Your contact's list seems to be empty",
                              style: AppFonts.regular14,
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )))
          ]),
        ),
      ),
    );
  }

  void _inviteSelectedPersons(
      BuildContext context, PersonListFetchedState state) {
    Uuid uuid = const Uuid();
    List<GuestData> invitedGuests = [];
    for (var element in state.list) {
      if (element.isSelected) {
        invitedGuests.add(
            GuestData(uuid.v4(), eventId, element.name, element.contactNo));
      }
    }
    BlocProvider.of<GuestBloc>(context).add(InviteGuestEvent(invitedGuests));
  }
}
