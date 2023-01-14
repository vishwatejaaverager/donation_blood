import 'package:cloud_firestore/cloud_firestore.dart';

class Streams {
  static const requests = 'requests';
  static const user = 'users';
  static const bloodRequest = 'blood_requests';

  final userQuery = FirebaseFirestore.instance.collection(user);
  final requestQuery = FirebaseFirestore.instance.collection(bloodRequest);
}
