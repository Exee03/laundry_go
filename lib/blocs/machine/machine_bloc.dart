import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/entities/machine_entity.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/repositories/machine_repository.dart';
import 'package:meta/meta.dart';

part 'machine_event.dart';
part 'machine_state.dart';

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final MachineRepository _machineRepository;
  List<Machine> _machines = [];
  StreamSubscription _streamSubscription;

  MachineBloc({@required MachineRepository machineRepository})
      : assert(machineRepository != null),
        _machineRepository = machineRepository;

  List<Machine> get machines => _machines;

  @override
  MachineState get initialState => MachineLoading();

  @override
  Stream<MachineState> mapEventToState(
    MachineEvent event,
  ) async* {
    if (event is MachinePreparing) {
      yield* _mapMachinePreparingToState();
    } else if (event is MachineRefresh) {
      yield* _mapMachineRefreshToState();
    } else if (event is MachineUpdated) {
      yield* _mapMachineUpdatedToState(event.machines);
    }
  }

  Stream<MachineState> _mapMachinePreparingToState() async* {
    if (machines.length == 0) {
      add(MachineRefresh());
    } else {
      yield MachineLoaded(machines);
    }
  }

  Stream<MachineState> _mapMachineUpdatedToState(
      List<Machine> newMachines) async* {
    _machines = newMachines;
    yield MachineLoaded(newMachines);
  }

  Stream<MachineState> _mapMachineRefreshToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription =
        _machineRepository.listMachines().listen((Event event) {
      _machines.clear();
      Map data = event.snapshot.value;
      data.forEach((index, data) =>
          _machines.add(Machine.fromEntity(MachineEntity.fromMap(data))));
      add(MachineUpdated(_machines));
    });
  }
}
