import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repositories/image_repository.dart';

part 'image_verification_screen_event.dart';
part 'image_verification_screen_state.dart';

class ImageVerificationScreenBloc
    extends Bloc<ImageVerificationScreenEvent, ImageVerificationScreenState> {
  final ImageScreeningRepository provider;
  late File image;
  ImageVerificationScreenBloc(this.provider) : super(ImageInitialState()) {
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
