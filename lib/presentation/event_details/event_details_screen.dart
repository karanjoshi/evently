import 'package:evently/presentation/add_event/add_event_screen.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/back_button.dart';
import 'package:evently/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';
import '../add_todo/add_todo_dialog.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.avatarBg,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const AppBackButton(),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "23 Nov",
                    textAlign: TextAlign.center,
                    style: AppFonts.regular48,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "at ",
                          style: AppFonts.regular18,
                          children: [
                        TextSpan(
                          text: "12:00",
                          style: AppFonts.regular32,
                        )
                      ])),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                padding: const EdgeInsets.all(40),
                clipBehavior: Clip.none,
                decoration: AppDecorations.appBgShadow,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doe’s Birthday",
                            style: AppFonts.regular32,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Party at Doe’s House",
                            style: AppFonts.light20,
                          ),
                          const SizedBox(
                            height: 20,
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
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "TO DOs",
                                style: AppFonts.regular20,
                              ),
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
                            height: 30,
                          ),
                          Flexible(
                            child: ListView(
                              shrinkWrap: true,
                              children:
                                  List.generate(10, (index) => _ToDoListItem()),
                            ),
                          )
                        ],
                      ),
                    ),
                    AppButton(
                        text: "Add To Do",
                        onClick: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              constraints:
                                  BoxConstraints.tight(Size.fromHeight(270)),
                              builder: (context) {
                                return AddToDoDialog();
                              });
                        })
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

class _ToDoListItem extends StatefulWidget {
  const _ToDoListItem({Key? key}) : super(key: key);

  @override
  State<_ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<_ToDoListItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCheckChanged,
      child: Container(
        decoration: AppDecorations.listItemBg.copyWith(
            color: isChecked ? AppColors.highlight : AppColors.bgColor),
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(
              isChecked
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: Colors.white,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Order Cake",
              style: AppFonts.regular18.copyWith(
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }

  void onCheckChanged() {
    setState(() {
      isChecked = !isChecked;
    });
  }
}
