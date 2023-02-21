import 'package:evently/theme/colors.dart';
import 'package:evently/theme/fonts.dart';
import 'package:flutter/material.dart';

abstract class AppDecorations {
  static final BoxDecoration appBgShadow = BoxDecoration(
      color: AppColors.bgColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(0, -10),
            spreadRadius: 0,
            blurRadius: 10)
      ]);

  static const BoxDecoration iconWithTextBg = BoxDecoration(
      color: AppColors.bgColor,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: AppColors.shadowColor, spreadRadius: 5, blurRadius: 10)
      ]);

  static const BoxDecoration avatarBg = BoxDecoration(
    color: AppColors.avatarBg,
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  static const BoxDecoration listItemBg = BoxDecoration(
      color: AppColors.bgColor,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: AppColors.shadowColor, spreadRadius: 2, blurRadius: 10)
      ]);

  static final InputDecoration textFieldDecoration = InputDecoration(
      fillColor: Colors.white,
      filled: true,
      focusColor: Colors.transparent,
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintStyle:
          AppFonts.regular18.copyWith(color: AppColors.textColorSecondary),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))));
}
