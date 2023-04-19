part of 'image_verification_screen_bloc.dart';

abstract class ImageVerificationScreenState {}

class ImageInitialState extends ImageVerificationScreenState {}

class ImageLoadingState extends ImageVerificationScreenState {}

class ImagePickedState extends ImageVerificationScreenState {
  File image;
  ImagePickedState(this.image);
}

class ImageVerifiedState extends ImageVerificationScreenState {
  bool isNsfw;
  ImageVerifiedState(this.isNsfw);
}
