part of 'landing_screen_bloc.dart';

abstract class LandingScreenEvent {}

class BottomTabChangeEvent extends LandingScreenEvent {
  int index;
  BottomTabChangeEvent(this.index);
}
