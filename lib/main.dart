import 'package:evently/presentation/home/home_screen.dart';
import 'package:evently/presentation/login/login_screen.dart';
import 'package:evently/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Evently',
        theme: ThemeData(backgroundColor: AppColors.bgColor),
        home: const LoginScreen(),
      ),
    );
  }
}
