import 'package:evently/bloc/todo/todo_bloc.dart';
import 'package:evently/data/model/todo_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';
import '../../widgets/app_button.dart';

class AddToDoDialog extends StatelessWidget {
  final String eventId;
  final TextEditingController textEditingController = TextEditingController();

  AddToDoDialog({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (BuildContext context, state) {
        if (state is TodoAddedState) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        decoration: AppDecorations.appBgShadow,
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: AppDecorations.textFieldDecoration
                  .copyWith(hintText: "Title"),
              style: AppFonts.regular18
                  .copyWith(color: AppColors.textColorSecondary),
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                      text: "Add",
                      onClick: () {
                        Uuid uuid = const Uuid();
                        BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(
                            TodoData(uuid.v4(), eventId,
                                textEditingController.text, false)));
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
