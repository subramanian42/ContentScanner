part of 'landing_screen_bloc.dart';

abstract class LandingScreenState {}

class LandingScreenInitial extends LandingScreenState {}

class BottomTabChangeState extends LandingScreenState {
  int selectedIndex;
  BottomTabChangeState(this.selectedIndex);
}
