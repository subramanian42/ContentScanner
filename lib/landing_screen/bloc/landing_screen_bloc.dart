import 'package:flutter_bloc/flutter_bloc.dart';
part 'landing_screen_event.dart';
part 'landing_screen_state.dart';

class LandingScreenBloc extends Bloc<LandingScreenEvent, LandingScreenState> {
  LandingScreenBloc() : super(LandingScreenInitial()) {
    on<BottomTabChangeEvent>(
      (event, emit) {
        emit(BottomTabChangeState(event.index));
      },
    );
  }
}
