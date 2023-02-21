import 'package:evently/data/repository/event_repo.dart';
import 'package:evently/presentation/add_event/add_event_screen.dart';
import 'package:evently/presentation/event_details/event_details_screen.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

import '../../data/model/event_data.dart';
import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<EventData> _list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                "Evently",
                style: AppFonts.logoText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(40),
                decoration: AppDecorations.appBgShadow,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _list.length,
                        itemBuilder: (context, index) => _EventListItem(
                          eventData: _list[index],
                        ),
                      ),
                    ),
                    AppButton(
                        text: "Plan Event",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AddEventScreen();
                          }));
                        })
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

class _EventListItem extends StatelessWidget {
  final EventData eventData;

  const _EventListItem({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const EventDetailsScreen();
        }));
      },
      child: Container(
        decoration: AppDecorations.listItemBg,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: AppDecorations.avatarBg,
                  child: Text(
                    "",
                    style: AppFonts.regular26,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                    text: TextSpan(
                        text: "at ",
                        style: AppFonts.regular12,
                        children: [
                      TextSpan(text: "12:00", style: AppFonts.regular20)
                    ])),
                const Spacer(),
                const Icon(
                  Icons.done_all,
                  color: AppColors.green,
                  size: 24,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "01/10",
                  style: AppFonts.regular18,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Doe's Birthday",
              style: AppFonts.regular18,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Party at Doe's house",
              style: AppFonts.regular14,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 138,
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      UserAvatar(
                        initialChar: "j",
                        color: AppColors.avatarBg,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      UserAvatar(
                        initialChar: "k",
                        color: Color(0xff605DCC),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      UserAvatar(
                        initialChar: "s",
                        color: Color(0xff875DCC),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      UserAvatar(
                        initialChar: "+4",
                        color: Color(0xffF5F5F5),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
