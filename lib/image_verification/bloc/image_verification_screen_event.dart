part of 'image_verification_screen_bloc.dart';

abstract class ImageVerificationScreenEvent {}

class ImagePickedEvent extends ImageVerificationScreenEvent {
  File image;
  ImagePickedEvent(this.image);
}

class VerifyImageEvent extends ImageVerificationScreenEvent {
  VerifyImageEvent();
}
