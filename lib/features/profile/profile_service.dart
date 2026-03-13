import "dart:io";
import "package:firebase_storage/firebase_storage.dart";

class ProfileService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String uid, File image) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final ref = _storage
          .ref()
          .child("users")
          .child(uid)
          .child("profile_$timestamp.jpg");

      // アップロード完了を待機
      await ref.putFile(image);

      // 保存されたファイルのURLを取得
      return await ref.getDownloadURL();
    } catch (e) {
      // 呼び出し元の画面でエラーを検知できるように再送
      rethrow;
    }
  }
}