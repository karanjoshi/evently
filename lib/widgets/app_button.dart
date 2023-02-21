import 'package:evently/theme/colors.dart';
import 'package:evently/theme/fonts.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const AppButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 313,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white),
        child: Center(
          child: Text(
            text,
            style: AppFonts.regular18
                .copyWith(color: AppColors.textColorSecondary),
          ),
        ),
      ),
    );
  }
}
