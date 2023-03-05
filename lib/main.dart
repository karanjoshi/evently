import 'package:evently/bloc/guest/guest_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventBloc>(
            create: (context) => EventBloc(InitialEventState())),
        BlocProvider<GuestBloc>(
            create: (context) => GuestBloc(GuestInitialState())),
      ],
      child: MaterialApp(
        title: 'Evently',
        theme: ThemeData(backgroundColor: AppColors.bgColor),
        home: const LoginScreen(),
      ),
    );
  }
}
