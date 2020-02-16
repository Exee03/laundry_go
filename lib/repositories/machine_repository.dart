import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/entities/entities.dart';
import 'package:laundry_go/models/machine.dart';

class MachineRepository {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  // StreamSubscription<Event> listMachines() {
  //   return databaseReference.onValue.listen((Event event) {
  //     return Machine.fromEntity(MachineEntity.fromDataSnapshot(event.snapshot));
  //   }, onError: (Object o) {
  //     final DatabaseError error = o;
  //     return error;
  //   });
  // }

  Stream<Event> listMachines() {
    return databaseReference.onValue;
  }

}
