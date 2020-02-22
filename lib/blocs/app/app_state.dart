part of 'app_bloc.dart';

abstract class AppState {
  const AppState();
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class SwitchScreen extends AppState {}

class ToHomeScreen extends AppState {}

class ToProfileScreen extends AppState {}
