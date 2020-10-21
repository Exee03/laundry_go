import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundry_go/models/user.dart' as app;

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  app.User _user;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  Future<String> createUserWithEmailAndPassword(
      {String name, int studentId, String password}) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: studentId.toString() + '@laundry.go', password: password);
    saveUserData(app.User(
      uid: currentUser.user.uid,
      name: name,
      studentId: studentId,
    ));
    return currentUser.user.uid;
  }

  Future<String> signInWithEmailAndPassword(
      {int studentId, String password}) async {
    final currentUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: studentId.toString() + '@laundry.go', password: password);
    return currentUser.user.uid;
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getFirebaseUser() async {
    User userInfo = await _firebaseAuth.currentUser;
    return userInfo;
  }

  Future<app.User> getCurrentUser() async {
    DocumentReference ref =
        _firestore.collection('users').doc((await this.getFirebaseUser()).uid);
    _user = app.User.fromSnapshot(await ref.get());
    return _user;
  }

  signOut() {
    return _firebaseAuth.signOut();
  }

  void saveUserData(app.User user) async {
    DocumentReference ref = _firestore.collection('users').doc(user.uid);
    _user = user;
    return ref.set(user.toEntity().toDocument(), SetOptions(merge: true));
    // return ref.setData({
    //   'uid': user.uid,
    //   'email': user.email,
    //   'displayName': user.name,
    //   'studentId': 'asds',
    //   'lastSeen': DateTime.now(),
    //   'photoUrl': user.photoUrl,
    // }, merge: true);
  }

  app.User get user => _user;
}
