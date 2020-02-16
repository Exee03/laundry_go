import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/entities/machine_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  final String id;
  final bool isDoorOpened;
  final bool isUsed;
  final int timestampStart;
  final int duration;

  Machine({
    String id,
    bool isDoorOpened,
    bool isUsed,
    int timestampStart,
    int duration,
  })  : this.id = id ?? '',
        this.isDoorOpened = isDoorOpened ?? false,
        this.isUsed = isUsed ?? false,
        this.timestampStart = timestampStart ?? Timestamp.now(),
        this.duration = duration ?? 0;

  // Machine.fromSnapshot(DocumentSnapshot data)
  //     : this(
  //         uid: data['uid'],
  //         isDoorOpened: data['isDoorOpened'],
  //         isUsed: data['isUsed'],
  //         timestampStart: data['timestampStart'],
  //         duration: data['duration'],
  //       );

  Machine.fromDataSnapshot(DataSnapshot data)
      : this(
          id: data.value['id'],
          isDoorOpened: data.value['isDoorOpened'],
          isUsed: data.value['isUsed'],
          timestampStart: data.value['timestampStart'],
          duration: data.value['duration'],
        );

  Machine copyWith({
    String id,
    bool isDoorOpened,
    bool isUsed,
    int timestampStart,
    int duration,
  }) {
    return Machine(
      id: id ?? this.id,
      isDoorOpened: isDoorOpened ?? this.isDoorOpened,
      isUsed: isUsed ?? this.isUsed,
      timestampStart: timestampStart ?? this.timestampStart,
      duration: duration ?? this.duration,
    );
  }

  @override
  int get hashCode => id.hashCode ^ isDoorOpened.hashCode ^ isUsed.hashCode ^ timestampStart.hashCode ^ duration.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Machine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isDoorOpened == other.isDoorOpened &&
          isUsed == other.isUsed &&
          timestampStart == other.timestampStart &&
          duration == other.duration;

  @override
  String toString() {
    return 'Machine { id: $id }';
  }

  MachineEntity toEntity() {
    return MachineEntity(id, isDoorOpened, isUsed, timestampStart, duration);
  }

  static Machine fromEntity(MachineEntity entity) {
    return Machine(
      id: entity.id,
      isDoorOpened: entity.isDoorOpened,
      isUsed: entity.isUsed,
      timestampStart: entity.timestampStart,
      duration: entity.duration,
    );
  }
}
