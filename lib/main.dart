import 'package:evently/presentation/home/home_screen.dart';
import 'package:evently/presentation/login/login_screen.dart';
import 'package:evently/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/event/event_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
      create: (BuildContext context) {
        return EventBloc(InitialEventState());
      },
      child: MaterialApp(
        title: 'Evently',
        theme: ThemeData(backgroundColor: AppColors.bgColor),
        home: const LoginScreen(),
      ),
    );
  }
}
