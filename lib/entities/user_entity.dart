import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final int studentId;

  const UserEntity(
    this.uid,
    this.name,
    this.studentId,
  );

  Map<String, Object> toJson() {
    return {
      "uid": uid,
      "name": name,
      "studentId": studentId,
    };
  }

  @override
  List<Object> get props => [
        uid,
        name,
        studentId,
      ];

  @override
  String toString() {
    return 'UserEntity { uid: $uid }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["uid"] as String,
      json["name"] as String,
      json["studentId"] as int,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data['uid'],
      snap.data['name'],
      snap.data['studentId'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "uid": uid,
      "name": name,
      "studentId": studentId,
    };
  }
}
