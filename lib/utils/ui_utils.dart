import 'package:flutter/material.dart';

import '../theme/fonts.dart';

showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    style: AppFonts.regular14,
  )));
}
