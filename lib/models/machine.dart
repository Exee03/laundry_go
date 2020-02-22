import 'package:firebase_database/firebase_database.dart';
import 'package:laundry_go/entities/machine_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  final String id;
  final String user;
  final bool isDoorOpened;
  final bool isUsed;
  final int timestampStart;
  final int duration;

  Machine({
    String id,
    String user,
    bool isDoorOpened,
    bool isUsed,
    int timestampStart,
    int duration,
  })  : this.id = id ?? '',
        this.user = user ?? '',
        this.isDoorOpened = isDoorOpened ?? false,
        this.isUsed = isUsed ?? false,
        this.timestampStart = timestampStart ?? Timestamp.now().millisecondsSinceEpoch,
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
          user: data.value['user'],
          isDoorOpened: data.value['isDoorOpened'],
          isUsed: data.value['isUsed'],
          timestampStart: data.value['timestampStart'],
          duration: data.value['duration'],
        );

  Machine copyWith({
    String id,
    String user,
    bool isDoorOpened,
    bool isUsed,
    int timestampStart,
    int duration,
  }) {
    return Machine(
      id: id ?? this.id,
      user: user ?? this.user,
      isDoorOpened: isDoorOpened ?? this.isDoorOpened,
      isUsed: isUsed ?? this.isUsed,
      timestampStart: timestampStart ?? this.timestampStart,
      duration: duration ?? this.duration,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      user.hashCode ^
      isDoorOpened.hashCode ^
      isUsed.hashCode ^
      timestampStart.hashCode ^
      duration.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Machine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          user == other.user &&
          isDoorOpened == other.isDoorOpened &&
          isUsed == other.isUsed &&
          timestampStart == other.timestampStart &&
          duration == other.duration;

  @override
  String toString() {
    return 'Machine { id: $id, user: $user, isDoorOpened: $isDoorOpened, isUsed: $isUsed, timestampStart: $timestampStart, duration: $duration }';
  }

  MachineEntity toEntity() {
    return MachineEntity(id, user, isDoorOpened, isUsed, timestampStart, duration);
  }

  static Machine fromEntity(MachineEntity entity) {
    return Machine(
      id: entity.id,
      user: entity.user,
      isDoorOpened: entity.isDoorOpened,
      isUsed: entity.isUsed,
      timestampStart: entity.timestampStart,
      duration: entity.duration,
    );
  }
}
