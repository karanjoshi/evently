import 'package:evently/theme/colors.dart';
import 'package:flutter/material.dart';

abstract class AppFonts {
  static const TextStyle _primary = TextStyle(
      fontFamily: 'flamenco',
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.normal);
  static const TextStyle _freeHand = TextStyle(
      fontFamily: 'freehand',
      color: AppColors.textColorPrimary,
      fontWeight: FontWeight.normal);

  static final TextStyle regular32 = _primary.copyWith(fontSize: 32);
  static final TextStyle regular18 = _primary.copyWith(fontSize: 18);
  static final TextStyle regular14 = _primary.copyWith(fontSize: 14);
  static final TextStyle regular26 = _primary.copyWith(fontSize: 26);
  static final TextStyle regular20 = _primary.copyWith(fontSize: 20);
  static final TextStyle regular12 = _primary.copyWith(fontSize: 12);
  static final TextStyle regular48 = _primary.copyWith(fontSize: 48);
  static final TextStyle light20 =
      _primary.copyWith(fontSize: 20, fontWeight: FontWeight.w300);

  static final TextStyle logoText = _freeHand.copyWith(fontSize: 62);
  static final TextStyle logoSmallText = _freeHand.copyWith(fontSize: 48);
}
