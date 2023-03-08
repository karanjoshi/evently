import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evently/data/model/guest_data.dart';

import '../../data/repository/guest_repo.dart';

part 'guest_event.dart';

part 'guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final GuestRepository repo;

  GuestBloc(super.initialState, {required this.repo}) {
    on<InviteGuestEvent>(_onInviteGuestEvent);
  }

  FutureOr<void> _onInviteGuestEvent(
      InviteGuestEvent event, Emitter<GuestState> emit) {
    for (var element in event.guestList) {
      repo.add(element);
    }

    emit(GuestInvitedState());
  }
}
