import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

class MachineEntity extends Equatable {
  final String id;
  final bool isDoorOpened;
  final bool isUsed;
  final int timestampStart;
  final int duration;

  const MachineEntity(
    this.id,
    this.isDoorOpened,
    this.isUsed,
    this.timestampStart,
    this.duration,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "isDoorOpened": isDoorOpened,
      "isUsed": isUsed,
      "timestampStart": timestampStart,
      "duration": duration,
    };
  }

  @override
  List<Object> get props => [
        id,
        isDoorOpened,
        isUsed,
        timestampStart,
        duration,
      ];

  @override
  String toString() {
    return 'MachineEntity { id: $id }';
  }

  static MachineEntity fromJson(Map<String, Object> json) {
    return MachineEntity(
      json["id"] as String,
      json["isDoorOpened"] as bool,
      json["isUsed"] as bool,
      json["timestampStart"] as int,
      json["duration"] as int,
    );
  }

  static MachineEntity fromMap(Map<dynamic, dynamic> map) {
    return MachineEntity(
      map["id"] as String,
      map["isDoorOpened"] as bool,
      map["isUsed"] as bool,
      map["timestampStart"] as int,
      map["duration"] as int,
    );
  }

  static MachineEntity fromSnapshot(DocumentSnapshot snap) {
    return MachineEntity(
      snap.data['id'],
      snap.data['isDoorOpened'],
      snap.data['isUsed'],
      snap.data['timestampStart'],
      snap.data['duration'],
    );
  }

  static MachineEntity fromDataSnapshot(DataSnapshot snap) {
    return MachineEntity(
      snap.value['id'],
      snap.value['isDoorOpened'],
      snap.value['isUsed'],
      snap.value['timestampStart'],
      snap.value['duration'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "isDoorOpened": isDoorOpened,
      "isUsed": isUsed,
      "timestampStart": timestampStart,
      "duration": duration,
    };
  }
}
