import 'package:laundry_go/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final int studentId;
  final String token;

  User({
    String uid,
    String name,
    int studentId,
    String token,
  })  : this.uid = uid ?? '',
        this.name = name ?? '',
        this.studentId = studentId ?? null,
        this.token = token ?? '';

  User.fromSnapshot(DocumentSnapshot data)
      : this(
          uid: data['uid'],
          name: data['name'],
          studentId: data['studentId'],
          token: data['token'],
        );

  User copyWith({
    String uid,
    String name,
    int studentId,
    String token,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      studentId: studentId ?? this.studentId,
      token: token ?? this.token,
    );
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ studentId.hashCode ^ token.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          studentId == other.studentId &&
          token == other.token;

  @override
  String toString() {
    return 'User { uid: $uid }';
  }

  UserEntity toEntity() {
    return UserEntity(uid, name, studentId, token);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      uid: entity.uid,
      name: entity.name,
      studentId: entity.studentId,
      token: entity.token,
    );
  }
}
