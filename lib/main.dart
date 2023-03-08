import 'package:evently/bloc/guest/guest_bloc.dart';
import 'package:evently/bloc/todo/todo_bloc.dart';
import 'package:evently/data/repository/event_repo.dart';
import 'package:evently/data/repository/guest_repo.dart';
import 'package:evently/data/repository/todo_repo.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepository(),
        ),
        RepositoryProvider<GuestRepository>(
          create: (context) => GuestRepository(),
        ),
        RepositoryProvider<TodoRepository>(
          create: (context) => TodoRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EventBloc>(
              create: (context) => EventBloc(
                    InitialEventState(),
                    eventRepo: RepositoryProvider.of<EventRepository>(context),
                    todoRepo: RepositoryProvider.of<TodoRepository>(context),
                    guestRepo: RepositoryProvider.of<GuestRepository>(context),
                  )),
          BlocProvider<GuestBloc>(
              create: (context) => GuestBloc(GuestInitialState(),
                  repo: RepositoryProvider.of<GuestRepository>(context))),
          BlocProvider<TodoBloc>(
              create: (context) =>
                  TodoBloc(NoTodoFoundState(), RepositoryProvider.of(context)))
        ],
        child: MaterialApp(
          title: 'Evently',
          theme: ThemeData(backgroundColor: AppColors.bgColor),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
