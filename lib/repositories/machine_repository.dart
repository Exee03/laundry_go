import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/models/machine.dart';

class MachineRepository {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  Stream<Event> listMachines() {
    return databaseReference.onValue;
  }

  Stream<Event> washingStatus(String id) {
    return databaseReference.child(id).onValue;
  }

  Future<void> updateMachine(Machine update) {
    return databaseReference
        .child(update.id)
        .update(update.toEntity().toDocument());
  }
}
