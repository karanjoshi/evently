import 'package:evently/data/model/event_data.dart';
import 'package:evently/data/repository/event_repo.dart';
import 'package:evently/presentation/guest_list/guest_list_screen.dart';
import 'package:evently/theme/colors.dart';
import 'package:evently/theme/decorations.dart';
import 'package:evently/theme/fonts.dart';
import 'package:evently/utils/ui_utils.dart';
import 'package:evently/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/back_button.dart';

class AddEventScreen extends ConsumerWidget {
  AddEventScreen({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackButton(),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Plan Event",
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
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: AppDecorations.textFieldDecoration
                              .copyWith(hintText: "Title"),
                          style: AppFonts.regular18
                              .copyWith(color: AppColors.textColorSecondary),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: AppDecorations.textFieldDecoration
                              .copyWith(hintText: "Description"),
                          maxLines: 4,
                          style: AppFonts.regular18
                              .copyWith(color: AppColors.textColorSecondary),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _openDatePicker(context),
                              child: const _IconWithText(
                                icon: Icons.date_range,
                                text: "Day",
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _openTimePicker(context),
                              child: const _IconWithText(
                                icon: Icons.access_time,
                                text: "Time",
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                                child: AppButton(
                                    text: "Done",
                                    onClick: () =>
                                        _validateAndStoreEvent(context, ref))),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _openDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2100));
    if (selectedDate != null) {
      date = selectedDate;
    }
  }

  Future<void> _openTimePicker(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (selectedTime != null) {
      time = selectedTime;
    }
  }

  void _validateAndStoreEvent(BuildContext context, WidgetRef ref) {
    if (date == null) {
      showErrorSnackbar(context, "Please select date of event");
      return;
    }
    if (time == null) {
      showErrorSnackbar(context, "Please select time of event");
      return;
    }
    final eventRepo = ref.watch(eventRepoProvider);
    EventData eventData = EventData(
        "123",
        _titleController.text,
        _descriptionController.text,
        DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute));
    eventRepo.add(eventData);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GuestListScreen(
        eventId: eventData.id,
      );
    }));
  }
}

class _IconWithText extends StatelessWidget {
  final String text;
  final IconData icon;

  const _IconWithText({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.iconWithTextBg,
      padding: const EdgeInsets.all(10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: AppColors.textColorPrimary,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            text,
            style: AppFonts.regular18,
          )
        ],
      ),
    );
  }
}
