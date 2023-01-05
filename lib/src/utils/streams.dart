import 'package:cloud_firestore/cloud_firestore.dart';

class Streams {
  static const user = 'users';

  final  userQuery = FirebaseFirestore.instance.collection(Streams.user);
}
