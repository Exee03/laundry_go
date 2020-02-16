part of 'machine_bloc.dart';

abstract class MachineEvent extends Equatable {
  const MachineEvent();
  @override
  List<Object> get props => [];
}

class MachinePreparing extends MachineEvent {}

class MachineUpdated extends MachineEvent {
  final List<Machine> machines;

  const MachineUpdated(this.machines);

  @override
  List<Object> get props => [machines];
}

class MachineRefresh extends MachineEvent {}
