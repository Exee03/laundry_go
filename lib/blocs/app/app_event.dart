part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object> get props => [];
}

class HomeScreenTap extends AppEvent {}

class ProfileScreenTap extends AppEvent {}
