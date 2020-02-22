part of 'washing_bloc.dart';

abstract class WashingEvent extends Equatable {
  const WashingEvent();
  @override
  List<Object> get props => [];
}

class StartScaning extends WashingEvent {}

class LoadedMachines extends WashingEvent {
  final List<Machine> machines;

  const LoadedMachines(this.machines);

  @override
  List<Object> get props => [machines];
}

class MachineSelected extends WashingEvent {
  final String id;

  const MachineSelected(this.id);

  @override
  List<Object> get props => [id];
}

class DurationSelected extends WashingEvent {
  final int duration;

  const DurationSelected(this.duration);

  @override
  List<Object> get props => [duration];
}

class DoneStart extends WashingEvent {
  final Machine machine;

  const DoneStart(this.machine);

  @override
  List<Object> get props => [machine];
}

class StopWashing extends WashingEvent {}

class DoneWashing extends WashingEvent {}
