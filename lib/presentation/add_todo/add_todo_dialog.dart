import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/decorations.dart';
import '../../theme/fonts.dart';
import '../../widgets/app_button.dart';

class AddToDoDialog extends StatelessWidget {
  const AddToDoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.appBgShadow,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          TextFormField(
            decoration:
                AppDecorations.textFieldDecoration.copyWith(hintText: "Title"),
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
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
