part of 'machine_bloc.dart';

abstract class MachineState {
  const MachineState();
  @override
  List<Object> get props => [];
}

class MachineLoading extends MachineState {
}

class MachineLoaded extends MachineState {
  final List<Machine> machines;

  const MachineLoaded([this.machines = const []]);

  @override
  List<Object> get props => [machines];

  @override
  String toString() => 'MachineLoaded { machines: $machines }';
}
