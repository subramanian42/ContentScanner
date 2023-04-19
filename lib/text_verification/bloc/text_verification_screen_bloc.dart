import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profanity_filter/profanity_filter.dart';
part 'text_verification_screen_event.dart';
part 'text_verification_screen_state.dart';

class TextVerificationScreenBloc
    extends Bloc<TextVerificationScreenEvent, TextVerificationScreenState> {
  TextVerificationScreenBloc() : super(TextVerificationScreenInitial()) {
    on<VerifyTextEvent>((event, emit) {
      final filter = ProfanityFilter();
      final containsBadWords = filter.hasProfanity(event.text);
      emit(TextVerified(containsBadWords));
    });
  }
}
