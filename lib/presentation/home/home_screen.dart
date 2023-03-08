import 'package:evently/bloc/event/event_bloc.dart';
import 'package:evently/bloc/todo/todo_bloc.dart';
import 'package:evently/presentation/add_event/add_event_screen.dart';
import 'package:evently/presentation/event_details/event_details_screen.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/model/event_data.dart';
import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<EventBloc>(context).add(FetchEventsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
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
                padding: const EdgeInsets.all(40),
                decoration: AppDecorations.appBgShadow,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: BlocBuilder<EventBloc, EventState>(
                          builder: (context, EventState state) {
                        if (state is EventFetchedState) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.events.length,
                            itemBuilder: (context, index) => _EventListItem(
                              eventData: state.events[index],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("No Events Planned!"),
                          );
                        }
                      }),
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
          return EventDetailsScreen(
            eventId: eventData.id,
          );
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
                    DateFormat("dd MMM").format(eventData.datetime),
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
                      TextSpan(
                          text: DateFormat("hh:mm").format(eventData.datetime),
                          style: AppFonts.regular20)
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
                  BlocProvider.of<TodoBloc>(context)
                      .getTodoCounts(eventData.todos),
                  style: AppFonts.regular18,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              eventData.title,
              style: AppFonts.regular18,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              eventData.description,
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
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventData.guests?.length,
                    itemBuilder: (context, index) {
                      return UserAvatar(
                        initialChar:
                            eventData.guests![index].name[0].toUpperCase(),
                        color: AppColors.avatarBg,
                      );
                    },
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
