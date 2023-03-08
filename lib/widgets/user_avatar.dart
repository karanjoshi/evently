import 'package:flutter/material.dart';

import '../theme/decorations.dart';
import '../theme/fonts.dart';

class UserAvatar extends StatelessWidget {
  final String initialChar;
  final Color color;

  const UserAvatar({Key? key, required this.initialChar, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.avatarBg.copyWith(color: color),
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(6),
      child: Text(
        initialChar.toUpperCase(),
        textAlign: TextAlign.center,
        style: AppFonts.regular18,
      ),
    );
  }
}
