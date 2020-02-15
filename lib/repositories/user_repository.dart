import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundry_go/models/user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  User _user;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  Future<String> createUserWithEmailAndPassword(
      {String name, int studentId, String password}) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: studentId.toString() + '@laundry.go', password: password);
    saveUserData(User(
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
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getFirebaseUser() async {
    FirebaseUser userInfo = await _firebaseAuth.currentUser();
    return userInfo;
  }

  Future<User> getCurrentUser() async {
    DocumentReference ref = _firestore
        .collection('users')
        .document((await this.getFirebaseUser()).uid);
    _user = User.fromSnapshot(await ref.get());
    return _user;
  }

  signOut() {
    return _firebaseAuth.signOut();
  }

  void saveUserData(User user) async {
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    return ref.setData(user.toEntity().toDocument(), merge: true);
    // return ref.setData({
    //   'uid': user.uid,
    //   'email': user.email,
    //   'displayName': user.name,
    //   'studentId': 'asds',
    //   'lastSeen': DateTime.now(),
    //   'photoUrl': user.photoUrl,
    // }, merge: true);
  }

  User get user => _user;
}
