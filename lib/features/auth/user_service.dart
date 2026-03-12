import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  final _db = FirebaseFirestore.instance;

  Future<bool> userExists (String uid) async {
    final _doc = await _db.collection("users").doc(uid).get();
    return _doc.exists;
  }

  Future<void> createUser({
    required String uid,
    required String nickname,
  }) async {

    await _db.collection("users").doc(uid).set({
      "nickname": nickname,
      "createdAt": FieldValue.serverTimestamp(),
      "profileImageUrl":null,
      "needsProfileSetup": true
    });

  }
}