part of 'image_bloc.dart';

abstract class ImageEvent {}

class ImagePickedEvent extends ImageEvent {
  File image;
  ImagePickedEvent(this.image);
}

class VerifyImageEvent extends ImageEvent {
  VerifyImageEvent();
}
