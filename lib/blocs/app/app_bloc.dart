import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  int lastIndex = 0;
  int currentIndex;
  @override
  AppState get initialState => AppInitial();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is HomeScreenTap) {
      yield* _mapHomeScreenTapToState();
    } else if (event is ProfileScreenTap) {
      yield* _mapProfileScreenToState();
    }
  }

  Stream<AppState> _mapHomeScreenTapToState() async* {
    currentIndex = 0;
    if (currentIndex != lastIndex) {
      lastIndex = currentIndex;
      yield SwitchScreen();
    }
    yield ToHomeScreen();
  }

  Stream<AppState> _mapProfileScreenToState() async* {
    currentIndex = 1;
    if (currentIndex != lastIndex) {
      lastIndex = currentIndex;
      yield SwitchScreen();
    }
    yield ToProfileScreen();
  }
}
