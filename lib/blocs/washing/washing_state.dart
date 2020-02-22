part of 'washing_bloc.dart';

abstract class WashingState {
  const WashingState();
  @override
  List<Object> get props => [];
}

class WashingLoading extends WashingState {}

class ScanCode extends WashingState {
  final List<Machine> machines;

  const ScanCode(this.machines);

  @override
  List<Object> get props => [machines];
}

class SelectDuration extends WashingState {}

class StartingWashing extends WashingState {
  final Machine machine;

  const StartingWashing(this.machine);

  @override
  List<Object> get props => [machine];
}

class Washing extends WashingState {
  final Machine machine;
  final String animation;
  final int startSec;
  final int durationSec;
  final int endSec;
  final int remain;

  const Washing(this.machine, this.animation, this.startSec, this.durationSec, this.endSec,
      this.remain);

  @override
  List<Object> get props => [machine, animation, startSec, durationSec, endSec, remain];
}

class StopingWashing extends WashingState {}

class NotifyWashing extends WashingState {}
