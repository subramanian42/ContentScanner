import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repositories/image_screening_provider.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageScreeningRepository provider;
  late File image;
  ImageBloc(this.provider) : super(ImageInitialState()) {
    on<ImagePickedEvent>(
      (event, emit) async {
        image = event.image;
        emit(ImagePickedState(image));
      },
    );
    on<VerifyImageEvent>(
      (event, emit) async {
        emit(ImageLoadingState());
        bool isNsfw = await provider.verifyImage(image);
        emit(ImageVerifiedState(isNsfw));
      },
    );
  }
}
