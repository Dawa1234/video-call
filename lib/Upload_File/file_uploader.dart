import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';

class Storage {
  final User? user = FirebaseAuth.instance.currentUser;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    print(user?.uid);
    File file = File(filePath);

    try {
      await storage.ref('test/${user?.uid}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found Files: $ref');
    });

    return result;
  }

  Future<String> downloadURL(String imagename) async {
    String downloadURL = await storage.ref('test/$imagename').getDownloadURL();

    return downloadURL;
  }
}
