part of 'text_verification_screen_bloc.dart';

abstract class TextVerificationScreenEvent {}

class VerifyTextEvent extends TextVerificationScreenEvent {
  String text;
  VerifyTextEvent(this.text);
}
