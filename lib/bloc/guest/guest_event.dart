part of 'guest_bloc.dart';

abstract class GuestEvent {}

class InviteGuestEvent extends GuestEvent {
  final List<GuestData> guestList;

  InviteGuestEvent(this.guestList);
}
