import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadProfileImage(String imageName, File image) async {
  String urlToReturn = '';
  Reference storageRef =
      FirebaseStorage.instance.ref().child('profile_images').child(imageName);
  final bytes = image.readAsBytesSync();
  String base64Encode(List<int> bytes) => base64.encode(bytes);
  String b64 = base64Encode(bytes);
  log("base 64: $b64 :base64");

  final UploadTask task = storageRef.putString('data:text/plain;base64,$b64',
      format: PutStringFormat.dataUrl);

  await task.whenComplete(() async {
    try {
      urlToReturn = await storageRef.getDownloadURL();
    } catch (onError) {
      log("Error:" '${onError.toString()}');
    }
    log(urlToReturn);
  });
  return urlToReturn;
}
