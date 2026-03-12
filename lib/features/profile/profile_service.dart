import "dart:io";
import "package:firebase_storage/firebase_storage.dart";

class ProfileService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String uid,File image) async{

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final ref = _storage
               .ref()
               .child("users")
               .child(uid)
               .child("profile_$timestamp.jpg");

    await ref.putFile(image);

    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}