import 'package:evently/presentation/contact_list/contact_list_screen.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/person_list_item.dart';
import 'package:flutter/material.dart';

import '../../data/model/guest_data.dart';
import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';
import '../../widgets/back_button.dart';

class GuestListScreen extends StatelessWidget {
  final String eventId;

  GuestListScreen({required this.eventId, Key? key}) : super(key: key);

  List<GuestData> _list = [];

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
              "Guest List",
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
                        itemBuilder: (context, index) => PersonListItem(
                          personData: _list[index],
                          selectable: false,
                        ),
                      ),
                    ),
                    AppButton(
                        text: "Invite",
                        onClick: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return ContactListScreen(
                              eventId: eventId,
                            );
                          }));
                        })
                  ],
                )))
      ]),
    ));
  }
}
