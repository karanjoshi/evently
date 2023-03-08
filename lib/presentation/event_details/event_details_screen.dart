import 'package:evently/bloc/event/event_bloc.dart';
import 'package:evently/bloc/todo/todo_bloc.dart';
import 'package:evently/data/model/todo_data.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:evently/widgets/back_button.dart';
import 'package:evently/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';
import '../add_todo/add_todo_dialog.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<EventBloc>(context)
        .add(FetchEventDetailsEvent(widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.avatarBg,
        body: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventDetailFetchedState) {
              BlocProvider.of<TodoBloc>(context)
                  .add(FetchTodoEvent(state.eventData.id));
            }
          },
          builder: (context, state) {
            if (state is EventDetailFetchedState) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBackButton(),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              DateFormat("dd MMM")
                                  .format(state.eventData.datetime),
                              textAlign: TextAlign.center,
                              style: AppFonts.regular48,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "at ",
                                    style: AppFonts.regular18,
                                    children: [
                                  TextSpan(
                                    text: DateFormat("hh:mm")
                                        .format(state.eventData.datetime),
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
                                      state.eventData.title,
                                      style: AppFonts.regular32,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.eventData.description,
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
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                state.eventData.guests?.length,
                                            itemBuilder: (context, index) {
                                              return UserAvatar(
                                                initialChar: state.eventData
                                                    .guests![index].name[0]
                                                    .toUpperCase(),
                                                color: AppColors.avatarBg,
                                              );
                                            },
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
                                        BlocBuilder<TodoBloc, TodoState>(
                                            builder: (context, state) {
                                          if (state is TodoFetchedState) {
                                            return Text(
                                              BlocProvider.of<TodoBloc>(context)
                                                  .getTodoCounts(state.todos),
                                              style: AppFonts.regular18,
                                            );
                                          } else {
                                            return Text(
                                              BlocProvider.of<TodoBloc>(context)
                                                  .getTodoCounts(null),
                                              style: AppFonts.regular18,
                                            );
                                          }
                                        })
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Flexible(
                                      child: BlocBuilder<TodoBloc, TodoState>(
                                          builder: (context, state) {
                                        if (state is TodoFetchedState) {
                                          return ListView.builder(
                                            itemCount: state.todos.length,
                                            itemBuilder: (context, index) {
                                              return _ToDoListItem(
                                                todoData: state.todos[index],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Text(
                                              "Add todo items for this event",
                                              style: AppFonts.regular14,
                                            ),
                                          );
                                        }
                                      }),
                                    )
                                  ],
                                ),
                              ),
                              AppButton(
                                  text: "Add To Do",
                                  onClick: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        constraints: BoxConstraints.tight(
                                            const Size.fromHeight(270)),
                                        builder: (context) {
                                          return AddToDoDialog(
                                            eventId: widget.eventId,
                                          );
                                        });
                                  })
                            ],
                          )),
                    )
                  ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ToDoListItem extends StatefulWidget {
  final TodoData todoData;

  const _ToDoListItem({Key? key, required this.todoData}) : super(key: key);

  @override
  State<_ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<_ToDoListItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      return InkWell(
        onTap: onCheckChanged,
        child: Container(
          decoration: AppDecorations.listItemBg.copyWith(
              color: widget.todoData.isCompleted
                  ? AppColors.highlight
                  : AppColors.bgColor),
          margin:
              const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Icon(
                widget.todoData.isCompleted
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                widget.todoData.title,
                style: AppFonts.regular18.copyWith(
                    decoration: widget.todoData.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      );
    });
  }

  void onCheckChanged() {
    widget.todoData.isCompleted = !widget.todoData.isCompleted;
    BlocProvider.of<TodoBloc>(context).add(UpdateTodoEvent(widget.todoData));
  }
}
