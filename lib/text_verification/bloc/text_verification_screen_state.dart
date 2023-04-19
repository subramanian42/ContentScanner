part of 'text_verification_screen_bloc.dart';

abstract class TextVerificationScreenState {}

class TextVerificationScreenInitial extends TextVerificationScreenState {}

class TextVerified extends TextVerificationScreenState {
  bool hasBadWords;
  TextVerified(this.hasBadWords);
}
