import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/entities/entities.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/models/user.dart';
import 'package:laundry_go/repositories/machine_repository.dart';
import 'package:meta/meta.dart';

part 'washing_event.dart';
part 'washing_state.dart';

enum AnimationToPlay {
  Idle,
  Start,
  Washing,
  Stop,
}

class WashingBloc extends Bloc<WashingEvent, WashingState> {
  final MachineRepository _machineRepository;
  final User _user;
  List<Machine> _machines = [];
  StreamSubscription _streamSubscription;
  Machine _machine;
  int timestamp;
  int startSec;
  int durationSec;
  int endSec;
  int remain;

  WashingBloc(
      {@required MachineRepository machineRepository, @required User user})
      : assert(machineRepository != null, user != null),
        _machineRepository = machineRepository,
        _user = user;

  @override
  WashingState get initialState => WashingLoading();

  @override
  Stream<WashingState> mapEventToState(
    WashingEvent event,
  ) async* {
    if (event is StartScaning) {
      yield* _mapLoadMachineToState();
    } else if (event is LoadedMachines) {
      yield* _mapLoadedMachinesToState();
    } else if (event is MachineSelected) {
      _machine = Machine(id: event.id);
      yield* _mapMachineSelectedToState();
    } else if (event is DurationSelected) {
      _machine = _machine.copyWith(
          duration: event.duration, isUsed: true, user: _user.uid);
      yield* _mapDurationSelectedToState();
    } else if (event is DoneStart) {
      if (_machine == null) {
        _machine = event.machine;
        getTime();
      }
      yield* _mapDoneStartToState();
    } else if (event is StopWashing) {
      yield* _mapStopWashingToState();
    } else if (event is DoneWashing) {
      yield* _mapDoneWashingToState();
    }
  }

  Stream<WashingState> _mapLoadMachineToState() async* {
    try {
      _streamSubscription?.cancel();
      _streamSubscription =
          _machineRepository.listMachines().listen((Event event) {
        _machines.clear();
        Map data = event.snapshot.value;
        data.forEach((index, data) =>
            _machines.add(Machine.fromEntity(MachineEntity.fromMap(data))));
        add(LoadedMachines(_machines));
        _streamSubscription?.cancel();
      }, onError: (Object o) {
        print('on error');
      });
    } catch (e) {
      print('errorr!!!');
    }
  }

  Stream<WashingState> _mapLoadedMachinesToState() async* {
    yield ScanCode(_machines);
  }

  String getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Idle:
        return 'idle';
      case AnimationToPlay.Start:
        return 'start';
      case AnimationToPlay.Washing:
        return 'washing';
      case AnimationToPlay.Stop:
        return 'stop';
      default:
        return 'idle';
    }
  }

  void getTime() {
    timestamp = Timestamp.now().millisecondsSinceEpoch;
    durationSec = (_machine.duration * 60);
    startSec = (_machine.timestampStart ~/ 1000);
    endSec = startSec + durationSec;
    remain =
        (_machine.duration * 60000) - (timestamp - _machine.timestampStart);
  }

  Stream<WashingState> _mapMachineSelectedToState() async* {
    yield SelectDuration();
  }

  Stream<WashingState> _mapDurationSelectedToState() async* {
    try {
      await _machineRepository.updateMachine(_machine);
      getTime();
      yield Washing(_machine, getAnimationName(AnimationToPlay.Start), startSec,
          durationSec, endSec, remain);
      Future.delayed(
          const Duration(seconds: 10), () => add(DoneStart(_machine)));
    } catch (e) {
      print('error: $e');
    }
  }

  Stream<WashingState> _mapDoneStartToState() async* {
    yield Washing(_machine, getAnimationName(AnimationToPlay.Washing), startSec,
        durationSec, endSec, remain);
  }

  Stream<WashingState> _mapStopWashingToState() async* {
    yield Washing(_machine, getAnimationName(AnimationToPlay.Stop), startSec,
        durationSec, endSec, remain);
    Future.delayed(const Duration(seconds: 10), () => add(DoneWashing()));
  }

  Stream<WashingState> _mapDoneWashingToState() async* {
    yield NotifyWashing();
  }
}
