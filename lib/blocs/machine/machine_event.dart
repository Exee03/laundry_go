part of 'machine_bloc.dart';

abstract class MachineEvent extends Equatable {
  const MachineEvent();
  @override
  List<Object> get props => [];
}

class MachinePreparing extends MachineEvent {}

class MachineListUpdated extends MachineEvent {
  final List<Machine> machines;

  const MachineListUpdated(this.machines);

  @override
  List<Object> get props => [machines];
}

class MachineRefresh extends MachineEvent {}

class MachineOnError extends MachineEvent {
  final DatabaseError error;
  
  const MachineOnError(this.error);

  @override
  List<Object> get props => [error];
}

