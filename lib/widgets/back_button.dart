import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Padding(
        padding: EdgeInsets.only(top: 30, left: 20),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.textColorPrimary,
          size: 36,
        ),
      ),
    );
  }
}
