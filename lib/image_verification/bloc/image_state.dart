part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImagePickedState extends ImageState {
  File image;
  ImagePickedState(this.image);
}

class ImageVerifiedState extends ImageState {
  bool isNsfw;
  ImageVerifiedState(this.isNsfw);
}
